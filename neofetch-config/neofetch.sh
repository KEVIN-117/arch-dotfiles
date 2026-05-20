#!/usr/bin/env bash
# Wrapper ultra-simplificado para Neofetch
# Elige una imagen aleatoria del directorio 'images/' en cada ejecución y aplica el HUD de color Ghost Cyan.

# Obtener el directorio absoluto del script
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
IMG_DIR="$DIR/images"

# Verificar si neofetch está instalado
if ! command -v neofetch &> /dev/null; then
    echo -e "\e[1;31m[!] Error: 'neofetch' no está instalado en tu sistema.\e[0m"
    echo -e "Por favor, instálalo ejecutando:"
    echo -e "   \e[1;32msudo pacman -S neofetch\e[0m (en Arch Linux)"
    exit 1
fi

# Seleccionar una imagen aleatoria del directorio de imágenes de forma segura
if [ -d "$IMG_DIR" ] && [ "$(ls -A "$IMG_DIR" 2>/dev/null)" ]; then
    # Usar 'shuf' si está disponible, o 'sort -R' como fallback robusto
    if command -v shuf &> /dev/null; then
        RANDOM_IMG="$(find "$IMG_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" \) | shuf -n 1)"
    else
        RANDOM_IMG="$(find "$IMG_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" \) | sort -R | head -n 1)"
    fi
else
    echo -e "\e[1;33m[!] Advertencia: No se encontraron imágenes en $IMG_DIR.\e[0m"
    echo -e "Mostrando logo ASCII por defecto..."
    RANDOM_IMG="auto"
fi

# Ejecutar Neofetch con la configuración Ghost Cyan y la imagen seleccionada
neofetch --config "$DIR/config.conf" --source "$RANDOM_IMG"
