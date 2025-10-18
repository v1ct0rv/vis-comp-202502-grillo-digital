"""Instalador del paquete de segmentación por color"""

from setuptools import setup, find_packages

setup(
    name="color_segmentation",
    version="0.1.0",
    author="Grillo Digital",
    description="Herramientas para segmentación de objetos por color usando OpenCV",
    packages=find_packages(),
    python_requires=">=3.9",
    install_requires=[
        "opencv-python==4.10.0.84",
        "numpy==1.26.4",
        "pandas==2.2.2",
        "matplotlib==3.9.1",
        "pathlib==1.0.1",
    ],
)