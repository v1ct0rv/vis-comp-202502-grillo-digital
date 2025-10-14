#!/bin/bash
# Script para convertir imágenes HEIC a JPEG sin compresión
# Uso: bash convert_heic_to_jpeg.sh

CALIB_DIR="photos/calibracion"

# Colores para output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "=========================================="
echo "Convertidor HEIC a JPEG (Sin compresión)"
echo "=========================================="

# Verificar si el directorio existe
if [ ! -d "$CALIB_DIR" ]; then
    echo -e "${RED}Error: El directorio $CALIB_DIR no existe.${NC}"
    exit 1
fi

# Contar archivos HEIC
HEIC_COUNT=$(ls "$CALIB_DIR"/*.{heic,HEIC} 2>/dev/null | wc -l | tr -d ' ')

if [ "$HEIC_COUNT" -eq 0 ]; then
    echo -e "${YELLOW}No se encontraron archivos HEIC en $CALIB_DIR${NC}"
    exit 0
fi

echo -e "\n${GREEN}Encontrados $HEIC_COUNT archivos HEIC${NC}"
echo "Directorio: $CALIB_DIR"
echo ""

# Verificar si sips está disponible (herramienta nativa de macOS)
if ! command -v sips &> /dev/null; then
    echo -e "${RED}Error: 'sips' no está disponible. Este script requiere macOS.${NC}"
    exit 1
fi

# Contador de conversiones
SUCCESS=0
FAILED=0

# Convertir cada archivo HEIC
for heic_file in "$CALIB_DIR"/*.{heic,HEIC}; do
    if [ -f "$heic_file" ]; then
        # Obtener nombre base sin extensión
        filename=$(basename "$heic_file")
        basename="${filename%.*}"
        
        # Nombre del archivo de salida
        jpeg_file="$CALIB_DIR/${basename}.jpeg"
        
        echo -n "Convirtiendo: $filename ... "
        
        # Convertir usando sips con calidad máxima (100 = sin compresión)
        if sips -s format jpeg -s formatOptions 100 "$heic_file" --out "$jpeg_file" > /dev/null 2>&1; then
            echo -e "${GREEN}✓ OK${NC}"
            SUCCESS=$((SUCCESS + 1))
            
            # Mostrar tamaños
            heic_size=$(du -h "$heic_file" | cut -f1)
            jpeg_size=$(du -h "$jpeg_file" | cut -f1)
            echo "  HEIC: $heic_size → JPEG: $jpeg_size"
        else
            echo -e "${RED}✗ FALLÓ${NC}"
            FAILED=$((FAILED + 1))
        fi
        echo ""
    fi
done

# Resumen
echo "=========================================="
echo "RESUMEN:"
echo "  Total archivos: $HEIC_COUNT"
echo -e "  ${GREEN}Convertidos: $SUCCESS${NC}"
if [ "$FAILED" -gt 0 ]; then
    echo -e "  ${RED}Fallidos: $FAILED${NC}"
fi
echo "=========================================="

# Preguntar si eliminar archivos HEIC originales
echo ""
read -p "¿Deseas eliminar los archivos HEIC originales? (s/n): " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Ss]$ ]]; then
    echo "Eliminando archivos HEIC..."
    rm "$CALIB_DIR"/*.{heic,HEIC} 2>/dev/null
    echo -e "${GREEN}✓ Archivos HEIC eliminados${NC}"
else
    echo "Los archivos HEIC se mantuvieron"
fi

echo ""
echo "¡Conversión completada!"
