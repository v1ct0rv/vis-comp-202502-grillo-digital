Análisis de imágenes

Este proyecto realiza un análisis de imágenes digitales capturadas desde un teléfono móvil, enfocado en transformaciones de intensidad, geométricas y de distribución de intensidades (histogramas).
El objetivo principal es comprender cómo varían las características visuales de una fachada en distintas condiciones de iluminación y cómo las operaciones matemáticas y espaciales pueden modificar su apariencia.

-------------------------------------------------------------------------------

# Configuración en MacOS y Linux

Ejecute los siguientes comandos en el terminal:

```bash
python3 -m venv .venv
source .venv/bin/activate
source setup.sh
```

# Configuración en Windows

Ejecute los siguientes comandos en el terminal:

```bash
python -m venv .venv
.venv\Scripts\activate
setup
```
-------------------------------------------------------------------------------

Dependencias principales:

opencv-python==4.10.0.84
numpy==1.26.4
pandas==2.2.2
matplotlib==3.8.4
Pillow==10.4.0
jupyter==1.1.1
pathlib==1.0.1

-------------------------------------------------------------------------------

-Ejecución del notebook:

Activa el entorno virtual.

Abre el notebook:
jupyter notebook Fachada.ipynb

Asegúrate de tener las dos imágenes (una de día y otra de noche) en la misma carpeta y actualiza las rutas IMG_DIA y IMG_NOCHE.

Ejecuta las celdas en orden.

Revisa los resultados generados (gráficos, videos, CSVs y visualizaciones intermedias).

-------------------------------------------------------------------------------

-Flujo de trabajo:

Carga y validación de imágenes.

Transformaciones de intensidad:

Brillo, contraste y corrección gamma implementadas manualmente.

Operaciones aritméticas entre imágenes: suma, resta, multiplicación, división.

Transformaciones geométricas: rotaciones, traslaciones y escalas encadenadas.

Ecualización del histograma: usando la CDF acumulada.

Comparación de histogramas diurnos y nocturnos.

Visualización final: gráficos de histogramas y animación de transformaciones.

-------------------------------------------------------------------------------

-Resultados esperados

Imágenes transformadas: resultados de brillo, contraste, gamma y operaciones aritméticas.

Video animado: mostrando las transformaciones geométricas.

Histogramas antes y después de la ecualización.
