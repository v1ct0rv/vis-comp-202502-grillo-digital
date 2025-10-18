"""Instalador del paquete de segmentación por color"""

from setuptools import setup, find_packages

setup(
    name="color_segmentation",
    version="0.1.1",
    author="Grillo Digital",
    description="Herramientas para segmentación y análisis de colores en imágenes usando OpenCV y NumPy",
    packages=find_packages(),
    python_requires=">=3.9",
    install_requires=[
        # Librerías principales
        "opencv-python==4.10.0.84",
        "numpy==1.26.4",
        "pandas==2.2.2",
        "matplotlib==3.8.4",
        "Pillow==10.4.0",

        # Entorno interactivo
        "jupyter==1.1.1",
        "ipykernel==6.29.4",
        "notebook==7.2.1",

        # Utilidades del sistema
        "pathlib==1.0.1",
    ],
)
