# Análisis y Procesamiento de Imágenes Digitales

Este proyecto implementa un flujo completo de procesamiento de imágenes digitales, enfocándose en tres componentes principales: calibración de cámara, análisis de fachadas en diferentes condiciones de iluminación, y segmentación de colores. El trabajo incluye implementaciones prácticas de transformaciones de intensidad, operaciones geométricas, análisis de histogramas y técnicas de segmentación usando OpenCV y Python.

## Objetivos del Proyecto

### Calibración de Cámara
- Estimar parámetros intrínsecos y coeficientes de distorsión
- Corregir distorsiones ópticas en imágenes
- Mejorar la fidelidad geométrica de las capturas

### Análisis de Fachadas
- Estudiar variaciones de iluminación entre día y noche
- Implementar transformaciones de intensidad y geométricas
- Analizar y modificar distribuciones tonales
- Generar secuencias animadas de transformaciones

### Segmentación de Colores
- Detectar y cuantificar regiones por color usando HSV
- Calcular áreas y estadísticas por región
- Generar máscaras y anotaciones visuales
- Exportar métricas detalladas en formato CSV

## Estructura del Proyecto

### 1. Calibración de Cámara (`1_calibracion_camara/`)
- Notebook para calibración de cámara (`calibracion_camara_v3.ipynb`)
- Archivo de parámetros de calibración (`calibracion_camara.npz`)
- Imágenes de calibración en `photos/calibracion/`

### 2. Análisis de Fachada (`Fachada/`)
Análisis de imágenes de una fachada en diferentes condiciones de iluminación, implementando:
- Transformaciones de intensidad (brillo, contraste, gamma)
- Operaciones aritméticas entre imágenes
- Transformaciones geométricas (rotación, traslación, escala)
- Análisis de histogramas y ecualización

### 3. Segmentación de Colores (`Segmentación/`)
Sistema de segmentación y análisis de colores que incluye:
- Detección de regiones por color usando espacio HSV
- Cálculo de áreas y métricas por región
- Generación de máscaras individuales
- Exportación de resultados en formato CSV

## Herramientas Auxiliares

### Scripts de Conversión (`scripts/`)
- `convert_heic_to_jpeg.sh`: Convierte imágenes de HEIC a JPEG
- `convert_jpg_to_png.sh`: Convierte imágenes de JPG a PNG

## Requisitos

Dependencias principales:
- opencv-python==4.10.0.84
- numpy==1.26.4
- pandas==2.2.2
- matplotlib==3.8.4
- Pillow==10.4.0 (para el módulo de Fachada)
- jupyter==1.1.1
- pathlib==1.0.1

## Configuración del Entorno

### En Windows:
```bash
python -m venv .venv
.venv\Scripts\activate
setup
```

### En MacOS y Linux:
```bash
python3 -m venv .venv
source .venv/bin/activate
source setup.sh
```

## Estructura de Directorios
```
.
├── 1_calibracion_camara/
│   ├── calibracion_camara_v3.ipynb
│   ├── calibracion_camara.npz
│   └── photos/
├── Fachada/
│   ├── Fachada.ipynb
│   ├── frames/
│   └── imagenes/
├── Segmentación/
│   ├── Segmentación.ipynb
│   ├── Imagenes/
│   └── salida_segmentacion_colores/
└── scripts/
    ├── convert_heic_to_jpeg.sh
    └── convert_jpg_to_png.sh
```

## Uso y Flujo de Trabajo

### 1. Configuración Inicial
1. Clone el repositorio
2. Configure el entorno virtual según su sistema operativo
3. Instale las dependencias requeridas

### 2. Calibración de Cámara
1. Capture 12-15 imágenes del patrón de calibración
2. Ejecute `calibracion_camara_v3.ipynb`
3. Verifique los parámetros generados en `calibracion_camara.npz`

### 3. Análisis de Fachada
1. Capture dos fotografías de la misma fachada (día y noche)
2. Coloque las imágenes en la carpeta `Fachada/imagenes/`
3. Ejecute `Fachada.ipynb`
4. Flujo de análisis:
   - Carga y validación de imágenes
   - Transformaciones de intensidad
   - Operaciones entre imágenes
   - Transformaciones geométricas
   - Análisis de histogramas
   - Generación de video de transformaciones

### 4. Segmentación de Colores
1. Prepare la imagen a segmentar
2. Ejecute `Segmentación.ipynb`
3. Revise los resultados en `salida_segmentacion_colores/`:
   - `anotada.png`: Imagen con etiquetas de colores
   - `resumen_por_color.csv`: Estadísticas por color
   - `objetos_por_color.csv`: Detalles por objeto
   - Máscaras individuales por color

## Resultados y Salidas

### Calibración de Cámara
- Matriz intrínseca K
- Coeficientes de distorsión
- Error de reproyección
- Imágenes corregidas de muestra

### Análisis de Fachada
- Imágenes procesadas con diferentes transformaciones
- Video de secuencia de transformaciones geométricas
- Histogramas comparativos (original vs. ecualizado)
- Análisis de distribución tonal día/noche

### Segmentación de Colores
Ejemplo de métricas generadas:

| Color   | Objetos | Área total (px) | Área promedio (px) |
|---------|---------|----------------|-------------------|
| Blanco  | 5       | 469,281        | 93,856.2         |
| Marrón  | 4       | 113,316        | 28,329.0         |
| Negro   | 4       | 71,670         | 17,917.5         |
| Gris    | 5       | 52,829         | 10,565.8         |
| Verde   | 5       | 39,769         | 7,953.8          |
| Rojo    | 2       | 10,572         | 5,286.0          |
| Naranja | 2       | 10,314         | 5,157.0          |

## Contribución

Para contribuir al proyecto:
1. Fork el repositorio
2. Cree una nueva rama (`git checkout -b feature/nueva-caracteristica`)
3. Commit sus cambios (`git commit -am 'Añade nueva característica'`)
4. Push a la rama (`git push origin feature/nueva-caracteristica`)
5. Cree un Pull Request