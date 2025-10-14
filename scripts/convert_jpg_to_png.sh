#!/bin/bash
# Script para convertir imágenes JPG/JPEG a PNG sin pérdida
# Uso: bash convert_jpg_to_png.sh [directorio] [porcentaje_escala]
# Ejemplo: bash convert_jpg_to_png.sh photos/calibracion 50  (reduce al 50%)

# Colores para output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo "=========================================="
echo "Convertidor JPG/JPEG a PNG"
echo "=========================================="

# Directorio objetivo (por defecto: photos/calibracion)
TARGET_DIR="${1:-photos/calibracion}"

# Porcentaje de escala (por defecto: 100 = tamaño original)
SCALE="${2:-100}"

# Porcentaje de escala (por defecto: 100 = tamaño original)
SCALE="${2:-100}"

# Validar porcentaje
if ! [[ "$SCALE" =~ ^[0-9]+$ ]] || [ "$SCALE" -lt 1 ] || [ "$SCALE" -gt 100 ]; then
    echo -e "${RED}Error: El porcentaje de escala debe ser un número entre 1 y 100${NC}"
    echo "Uso: bash convert_jpg_to_png.sh [directorio] [porcentaje]"
    echo "Ejemplo: bash convert_jpg_to_png.sh photos/calibracion 50"
    exit 1
fi

# Verificar si el directorio existe
if [ ! -d "$TARGET_DIR" ]; then
    echo -e "${RED}Error: El directorio $TARGET_DIR no existe.${NC}"
    exit 1
fi

# Contar archivos JPG/JPEG
JPG_COUNT=$(ls "$TARGET_DIR"/*.{jpg,jpeg,JPG,JPEG} 2>/dev/null | wc -l | tr -d ' ')

if [ "$JPG_COUNT" -eq 0 ]; then
    echo -e "${YELLOW}No se encontraron archivos JPG/JPEG en $TARGET_DIR${NC}"
    exit 0
fi

echo -e "\n${GREEN}Encontrados $JPG_COUNT archivos JPG/JPEG${NC}"
echo "Directorio: $TARGET_DIR"
if [ "$SCALE" -eq 100 ]; then
    echo -e "${CYAN}Tamaño: Original (100%)${NC}"
else
    echo -e "${CYAN}Tamaño: Reducido al ${SCALE}%${NC}"
fi
echo ""

# Verificar si sips está disponible (herramienta nativa de macOS)
if ! command -v sips &> /dev/null; then
    echo -e "${RED}Error: 'sips' no está disponible. Este script requiere macOS.${NC}"
    exit 1
fi

# Contador de conversiones
SUCCESS=0
FAILED=0

# Convertir cada archivo JPG/JPEG
for jpg_file in "$TARGET_DIR"/*.{jpg,jpeg,JPG,JPEG}; do
    if [ -f "$jpg_file" ]; then
        # Obtener nombre base sin extensión
        filename=$(basename "$jpg_file")
        basename="${filename%.*}"
        
        # Nombre del archivo de salida
        png_file="$TARGET_DIR/${basename}.png"
        
        echo -n "Convirtiendo: $filename ... "
        
        # Convertir usando sips (sin compresión, formato PNG)
        if [ "$SCALE" -eq 100 ]; then
            # Conversión sin redimensionar
            if sips -s format png "$jpg_file" --out "$png_file" > /dev/null 2>&1; then
                echo -e "${GREEN}✓ OK${NC}"
                SUCCESS=$((SUCCESS + 1))
                
                # Mostrar tamaños
                jpg_size=$(du -h "$jpg_file" | cut -f1)
                png_size=$(du -h "$png_file" | cut -f1)
                echo "  JPG: $jpg_size → PNG: $png_size"
            else
                echo -e "${RED}✗ FALLÓ${NC}"
                FAILED=$((FAILED + 1))
            fi
        else
            # Conversión con redimensionamiento
            # Primero obtener dimensiones originales
            orig_width=$(sips -g pixelWidth "$jpg_file" 2>/dev/null | grep "pixelWidth" | awk '{print $2}')
            orig_height=$(sips -g pixelHeight "$jpg_file" 2>/dev/null | grep "pixelHeight" | awk '{print $2}')
            
            # Calcular nuevas dimensiones
            new_width=$(( orig_width * SCALE / 100 ))
            new_height=$(( orig_height * SCALE / 100 ))
            
            # Convertir con las nuevas dimensiones
            if sips -s format png -z "$new_height" "$new_width" "$jpg_file" --out "$png_file" > /dev/null 2>&1; then
                echo -e "${GREEN}✓ OK${NC}"
                SUCCESS=$((SUCCESS + 1))
                
                # Mostrar tamaños y dimensiones
                jpg_size=$(du -h "$jpg_file" | cut -f1)
                png_size=$(du -h "$png_file" | cut -f1)
                echo "  JPG: $jpg_size (${orig_width}x${orig_height}) → PNG: $png_size (${new_width}x${new_height})"
            else
                echo -e "${RED}✗ FALLÓ${NC}"
                FAILED=$((FAILED + 1))
            fi
        fi
        echo ""
    fi
done

# Resumen
echo "=========================================="
echo "RESUMEN:"
echo "  Total archivos: $JPG_COUNT"
echo -e "  ${GREEN}Convertidos: $SUCCESS${NC}"
if [ "$FAILED" -gt 0 ]; then
    echo -e "  ${RED}Fallidos: $FAILED${NC}"
fi
echo "=========================================="

# Preguntar si eliminar archivos JPG originales
echo ""
read -p "¿Deseas eliminar los archivos JPG/JPEG originales? (s/n): " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Ss]$ ]]; then
    echo "Eliminando archivos JPG/JPEG..."
    rm "$TARGET_DIR"/*.{jpg,jpeg,JPG,JPEG} 2>/dev/null
    echo -e "${GREEN}✓ Archivos JPG/JPEG eliminados${NC}"
else
    echo "Los archivos JPG/JPEG se mantuvieron"
fi

echo ""
echo "¡Conversión completada!"
echo ""
if [ "$SCALE" -lt 100 ]; then
    echo -e "${BLUE}Nota: Las imágenes fueron reducidas al ${SCALE}% de su tamaño original${NC}"
    echo -e "${BLUE}PNG es un formato sin pérdida, ideal para procesamiento de imágenes.${NC}"
else
    echo -e "${BLUE}Nota: PNG es un formato sin pérdida, ideal para procesamiento de imágenes.${NC}"
fi
