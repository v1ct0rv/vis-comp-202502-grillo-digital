Segmentación de Colores con OpenCV

Este proyecto realiza la detección, segmentación y análisis de colores en imágenes digitales utilizando OpenCV, NumPy y Pandas.
Permite identificar regiones por color, calcular su área, generar máscaras individuales y exportar resultados en formato CSV.

-------------------------------------------------------------------------------------------------------------------------------

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

-------------------------------------------------------------------------------------------------------------------------------

-Dependencias principales:

opencv-python==4.10.0.84
numpy==1.26.4
pandas==2.2.2
matplotlib==3.8.4
jupyter==1.1.1
pathlib==1.0.1

-------------------------------------------------------------------------------------------------------------------------------

Ejecución del Notebook

1. Abre el notebook:

jupyter notebook Segmentación.ipynb

2. Asegúrate de tener una imagen en la carpeta del proyecto.

3. Ejecuta las celdas en orden.

4. Los resultados generados se guardarán en la carpeta salidas/ o OUT_DIR/:

-anotada.png: imagen con etiquetas de colores detectados

-resumen_por_color.csv: tabla resumen por color

-objetos_por_color.csv: tabla detallada por cada objeto

-mask_color.png: máscara individual por color

-------------------------------------------------------------------------------------------------------------------------------

Resultados esperados
| Color   | Objetos | Área total (px) | Área promedio (px) |
| :------ | ------: | --------------: | -----------------: |
| Blanco  |       5 |         469,281 |           93,856.2 |
| Marrón  |       4 |         113,316 |           28,329.0 |
| Negro   |       4 |          71,670 |           17,917.5 |
| Gris    |       5 |          52,829 |           10,565.8 |
| Verde   |       5 |          39,769 |            7,953.8 |
| Rojo    |       2 |          10,572 |            5,286.0 |
| Naranja |       2 |          10,314 |            5,157.0 |


El sistema detecta los colores definidos en un rango HSV personalizado y genera estadísticas precisas sobre cada uno.