# Análisis y Procesamiento de Imágenes Digitales

## Descripción General
Este proyecto implementa un flujo completo de procesamiento de imágenes digitales, desarrollado como parte del curso de Visión por Computador. El trabajo se divide en tres componentes principales:

1. **Calibración de Cámara**: Estimación de parámetros intrínsecos y corrección de distorsiones
2. **Análisis de Fachadas**: Estudio de condiciones de iluminación y transformaciones de imagen
3. **Segmentación de Colores**: Detección y análisis de regiones por color usando HSV

## Estado del Proyecto
- **Estado**: En desarrollo
- **Última Actualización**: Octubre 18, 2025
- **Versión**: 1.0.0

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

## Requisitos del Sistema

### Prerequisitos
- Python 3.8 o superior
- Git (para clonar el repositorio)
- Sistema operativo compatible (Windows, macOS, o Linux)

### Dependencias Principales
- opencv-python==4.10.0.84 - Procesamiento de imágenes y visión por computador
- numpy==1.26.4 - Computación numérica y arrays
- pandas==2.2.2 - Análisis de datos y manipulación de DataFrames
- matplotlib==3.8.4 - Visualización de datos y gráficos
- Pillow==10.4.0 - Procesamiento de imágenes y formatos
- jupyter==1.1.1 - Entorno interactivo de notebooks
- pathlib==1.0.1 - Manipulación de rutas del sistema de archivos

## Instalación y Configuración

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

## Guía de Uso

### Configuración Inicial del Proyecto
```bash
# 1. Clonar el repositorio
git clone https://github.com/v1ct0rv/vis-comp-202502-grillo-digital.git
cd vis-comp-202502-grillo-digital

# 2. Crear y activar el entorno virtual según su sistema
# Windows:
python -m venv .venv
.venv\Scripts\activate

# macOS/Linux:
python3 -m venv .venv
source .venv/bin/activate

# 3. Instalar dependencias
pip install -r requirements.txt
```

### Módulos del Proyecto

#### 1. Calibración de Cámara
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

#### 3. Segmentación de Colores (`Segmentación.ipynb`)
1. Prepare la imagen a segmentar
2. Ejecute el notebook siguiendo las instrucciones paso a paso
3. Los resultados se guardarán en `salida_segmentacion_colores/`:
   - `anotada.png`: Visualización de regiones detectadas
   - `resumen_por_color.csv`: Métricas agregadas por color
   - `objetos_por_color.csv`: Detalles de cada objeto detectado
   - Máscaras binarias por cada color detectado

## Documentación Detallada

### Estructura de Directorios
```
.
├── 1_calibracion_camara/           # Módulo de calibración
│   ├── calibracion_camara_v3.ipynb # Notebook principal de calibración
│   ├── calibracion_camara.npz      # Parámetros de calibración guardados
│   └── photos/                     # Fotos para calibración
│       └── calibracion/           # Imágenes del patrón de calibración
├── docs/                          # Documentación detallada
│   ├── Informe_final_Grillo_Digital.html
│   └── Informe_final_Grillo_Digital.md
├── Fachada/                       # Módulo de análisis de fachadas
│   ├── Fachada.ipynb             # Notebook principal de análisis
│   ├── README.md                 # Documentación específica
│   ├── requirements.txt          # Dependencias específicas
│   ├── setup.bat                 # Script de configuración Windows
│   ├── setup.py                  # Script de configuración Python
│   ├── setup.sh                  # Script de configuración Unix
│   ├── color_segmentation.egg-info/  # Información del paquete
│   │   ├── dependency_links.txt
│   │   ├── PKG-INFO
│   │   ├── requires.txt
│   │   ├── SOURCES.txt
│   │   └── top_level.txt
│   ├── frames/                   # Frames generados de transformaciones
│   ├── imagenes/                 # Imágenes de fachadas
├── photos/                       # Directorio general de fotos
│   └── fachada/                 # Fotos de fachadas sin procesar
├── scripts/                      # Scripts de utilidad
│   ├── convert_heic_to_jpeg.sh  # Conversión de HEIC a JPEG
│   └── convert_jpg_to_png.sh    # Conversión de JPG a PNG
├── Segmentación/                 # Módulo de segmentación de colores
│   ├── README.md                # Documentación específica
│   ├── requirements.txt         # Dependencias específicas
│   ├── Segmentación.ipynb      # Notebook principal de segmentación
│   ├── setup.bat               # Script de configuración Windows
│   ├── setup.py               # Script de configuración Python
│   ├── setup.sh               # Script de configuración Unix
│   ├── color_segmentation.egg-info/  # Información del paquete
│   │   ├── dependency_links.txt
│   │   ├── PKG-INFO
│   │   ├── requires.txt
│   │   ├── SOURCES.txt
│   │   └── top_level.txt
│   ├── Imagenes/              # Imágenes para segmentación
│   └── salida_segmentacion_colores/  # Resultados de segmentación
│       ├── objetos_por_color.csv    # Detalles por objeto
│       └── resumen_por_color.csv    # Resumen estadístico
├── requirements.txt            # Dependencias globales del proyecto
└── README.md                  # Documentación principal

## Resultados y Visualizaciones

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

## Equipo de Desarrollo - Grillo Digital

- Andres Felipe Moreno Calle
- David Giraldo Valencia
- Juan Pablo Palacio Perez
- Victor Manuel Velasquez Cabeza

## Contribución y Desarrollo

### Cómo Contribuir
1. Fork el repositorio
2. Cree una nueva rama (`git checkout -b feature/nueva-caracteristica`)
3. Realice sus cambios y documente según las guías del proyecto
4. Commit sus cambios (`git commit -am 'Añade nueva característica'`)
5. Push a la rama (`git push origin feature/nueva-caracteristica`)
6. Cree un Pull Request

### Guías de Contribución
- Siga las convenciones de código existentes
- Documente todos los cambios significativos
- Incluya ejemplos y casos de prueba relevantes
- Actualice la documentación según sea necesario

## Licencia
Este proyecto está bajo la Licencia MIT. Consulte el archivo `LICENSE` para más detalles.

## Contacto
Para preguntas o sugerencias, por favor abra un issue en el repositorio.