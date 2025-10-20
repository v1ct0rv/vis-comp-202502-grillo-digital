# Informe técnico: calibración de cámara, análisis de imágenes de fachadas y segmentación de colores

**Equipo:** Grillo Digital  
**Repositorio base:** `vis-comp-202502-grillo-digital-main/`  
**Enfoque:** Implementación reproducible con resultados numéricos y visuales clave.

> Este documento consolida resultados y evidencias de: calibración de cámara, operaciones de intensidad, transformaciones geométricas, ecualización de histograma (CDF) y segmentación por color. Se referencia directamente a artefactos dentro del proyecto.

## Índice
1. [Resumen](#1-resumen)
2. [Introducción](#2-introducción)
3. [Objetivos y alcance](#3-objetivos-y-alcance)
4. [Fundamento técnico](#4-fundamento-técnico)
   - [4.1 Calibración de cámara y distorsión](#41-calibración-de-cámara-y-distorsión)
   - [4.2 Transformaciones de intensidad y distribución tonal](#42-transformaciones-de-intensidad-y-distribución-tonal)
   - [4.3 Segmentación por color en HSV y componentes conectados](#43-segmentación-por-color-en-hsv-y-componentes-conectados)
5. [Metodología por componente](#5-metodología-por-componente)
   - [5.1 Calibración de cámara](#51-calibración-de-cámara)
   - [5.2 Operaciones de intensidad](#52-operaciones-de-intensidad)
   - [5.3 Transformaciones + GIF/Video](#53-transformaciones--gifvideo)
   - [5.4 Histogramas + ecualización](#54-histogramas--ecualización)
   - [5.5 Segmentación por color](#55-segmentación-por-color)
6. [Resultados y análisis](#6-resultados-y-análisis)
   - [6.1 Calibración de cámara](#61-calibración-de-cámara)
   - [6.2 Análisis de fachada](#62-análisis-de-fachada)
   - [6.3 Segmentación por color](#63-segmentación-por-color)
7. [Discusión y análisis crítico](#7-discusión-y-análisis-crítico)
8. [Conclusiones](#8-conclusiones)
9. [Contribución individual](#9-contribución-individual)
10. [Referencias](#10-referencias)

## 1. Resumen

Este informe presenta un flujo integral de procesamiento de imágenes dividido en tres etapas: (1) calibración de cámara, (2) análisis de imágenes de fachadas y (3) segmentación por color. En la primera etapa se estiman los parámetros intrínsecos de la cámara y los coeficientes de distorsión a partir de un patrón de tablero de ajedrez, con el fin de corregir distorsiones ópticas y mejorar la fidelidad geométrica de las imágenes. En la segunda parte se analizan fotografías de una fachada capturadas en condiciones de iluminación distintas (6:00 a. m. y 7:00 p. m.), aplicando transformaciones de intensidad (brillo, contraste y gamma), operaciones aritméticas entre imágenes y transformaciones geométricas (rotación, traslación y escalado), además de histogramas y ecualización. Finalmente, en la tercera parte se construye un sistema de segmentación por color en el espacio HSV para cuantificar objetos y áreas por color, generando máscaras, una imagen anotada y resúmenes en CSV.

Los resultados muestran que la calibración reduce el error de reproyección a un rango compatible con una rectificación visualmente estable; que las transformaciones de intensidad permiten controlar el rango dinámico y hacer comparables imágenes de distinta iluminación; y que la segmentación por color con umbrales HSV ofrece un desempeño robusto para colores bien separados, con limitaciones en tonos poco saturados o bajo condiciones de iluminación complejas. El informe concluye con recomendaciones metodológicas y propuestas de mejora (CLAHE, ajuste automático de umbrales y procesamiento por lotes).

## 2. Introducción

La visión por computador integra técnicas de geometría, fotometría y aprendizaje automático para extraer información útil de imágenes. Un reto recurrente en aplicaciones prácticas es la variabilidad de la captura: diferentes cámaras, ópticas y condiciones de iluminación impactan tanto la apariencia como la geometría de la escena. En este trabajo abordamos esa variabilidad desde tres frentes complementarios: la calibración (para corregir distorsión y conocer el modelo de cámara), el análisis y operaciones de intensidad (para entender y controlar la distribución tonal y los contrastes) y la segmentación por color (para describir la escena a partir de regiones cromáticas), además de implementar transformaciones geométricas sobre una imagen y generar un vídeo con la secuencia de las transformaciones.

La calibración se realizó con base en un tablero de ajedrez de 9x6 con 25mm de lado, pegado a una pared. Por otro lado, el análisis y las operaciones de intensidad, así como las transformaciones geométricas, se realizaron sobre imágenes de una fachada. Analizar imágenes en dos horarios permite evidenciar cómo la iluminación modifica la distribución de intensidades y el color percibido. Además, cuantificar colores de interés (blancos, grises, marrones, verdes, etc.) brinda una base para análisis arquitectónicos, inventarios de pintura, vegetación u otras aplicaciones urbanas.

## 3. Objetivos y alcance

- **Calibrar una cámara real**: obtener parámetros intrínsecos (K: *fx, fy, cx, cy*) y coeficientes de distorsión (*k1, k2, p1, p2, k3*), reportar RMS de reproyección y corregir la distorsión de imágenes de muestra.
- **Aplicar operaciones de intensidad a nivel de píxel**: brillo, contraste, gamma y combinaciones A±B, A×B, A÷B.
- **Implementar transformaciones geométricas**: rotaciones, traslaciones y escalas; generar video y guardar todos los frames.
- **Manipular la distribución de intensidades**: Analizar histogramas y realizar ecualización por CDF comparando día vs. noche.
- **Segmentar por color**: Segmentar objetos por color, contar objetos y calcular áreas.

## 4. Fundamento técnico

### 4.1 Calibración de cámara y distorsión

El modelo pinhole describe la proyección de puntos 3D al plano imagen mediante una matriz intrínseca K que contiene la distancia focal y el centro principal, y matrices/extrínsecos que relacionan el sistema de la cámara con el mundo. En cámaras reales, lentes y ensamblajes introducen distorsiones radiales y tangenciales (por ejemplo, distorsión de barril o cojín), que curvan líneas rectas y desplazan píxeles.

La matriz de transformación afín se representa como:

```math
A = \begin{bmatrix}
a_{11} & a_{12} & t_x \\
a_{21} & a_{22} & t_y
\end{bmatrix}
```

Y la matriz de rotación como:

```math
R_\theta = \begin{bmatrix}
\cos\theta & -\sin\theta \\
\sin\theta & \cos\theta
\end{bmatrix}
```

### 4.2 Transformaciones de intensidad y distribución tonal

La luminancia (Y) resume la sensación de brillo de los píxeles. Las transformaciones incluyen:
- Brillo: desplazamiento de intensidad
- Contraste: estiramiento/estrechamiento del rango
- Gamma: función no lineal (out = inγ)

### 4.3 Segmentación por color en HSV

El espacio HSV separa:
- H (Hue): Tono cromático
- S (Saturation): Pureza del color
- V (Value): Brillo

## 5. Metodología por componente

### 5.1 Calibración de cámara

Proceso:
- 12-15 imágenes del patrón
- Detección de esquinas con OpenCV
- Estimación de parámetros
- Validación visual

### 5.2 Análisis de fachada

Pasos:
1. Captura de imágenes día/noche
2. Transformaciones de intensidad
3. Operaciones aritméticas
4. Análisis de histogramas

### 5.3 Segmentación por color

Procedimiento:
1. Definición de rangos HSV
2. Generación de máscaras
3. Análisis de componentes
4. Exportación de resultados

## 6. Resultados y análisis

### 6.1 Calibración de cámara

Resultados clave:
- Error de reproyección < 1 px
- Corrección visible de distorsión
- Parámetros consistentes

### 6.2 Análisis de fachada

Hallazgos:
- Diferencias en distribución tonal
- Efectividad de transformaciones
- Mejoras en contraste local

### 6.3 Segmentación por color

**Tabla 1. Ejemplo de resumen por color (conteos y áreas)**

| Color   | Objetos | Área total (px) | Área promedio (px) |
|---------|---------|-----------------|-------------------|
| Blanco  | 5       | 469,281        | 93,856.2         |
| Marrón  | 4       | 113,316        | 28,329.0         |
| Negro   | 4       | 71,670         | 17,917.5         |
| Gris    | 5       | 52,829         | 10,565.8         |
| Verde   | 5       | 39,769         | 7,953.8          |
| Rojo    | 2       | 10,572         | 5,286.0          |
| Naranja | 2       | 10,314         | 5,157.0          |

## 7. Discusión y análisis crítico

### 7.1 Logros principales
- Calibración consistente
- Normalización fotométrica efectiva
- Segmentación reproducible

### 7.2 Limitaciones
- Dependencia de iluminación
- Dificultad con tonos poco saturados
- Artefactos en transformaciones

### 7.3 Recomendaciones
- Preprocesamiento robusto
- Umbrales adaptativos
- Validación exhaustiva

## 8. Conclusiones

El proyecto demuestra un flujo de trabajo efectivo para:
- Corrección de distorsiones ópticas
- Análisis de iluminación
- Segmentación por color
- Cuantificación de escenas

## 9. Contribución individual

| Integrante | Actividades clave |
|------------|------------------|
| Andres Felipe Moreno Calle | Analisis Calibracion, Segmentación, Documentación  |
| David Giraldo Valencia | Calibración, segmentación, documentación |
| Juan Pablo Palacio Perez | Calibración, análisis, redacción |
| Victor Manuel Velasquez Cabeza | Calibración, fotografía |

## 10. Referencias

- Sadekar, K., & Mallick, S. (2020). *Camera Calibration using OpenCV.*
- Bradski, G. (2000). *The OpenCV Library.*
- Gonzalez, R. C., & Woods, R. E. (2018). *Digital Image Processing.*
- Szeliski, R. (2022). *Computer Vision: Algorithms and Applications.*