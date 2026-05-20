#!/usr/bin/env bash
# Wrapper para ejecutar Neofetch con nuestro HUD cyberpunk y el banner Dune Rise

# Obtener el directorio absoluto del script
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Verificar si neofetch está instalado
if ! command -v neofetch &> /dev/null; then
    echo -e "\e[1;31m[!] Error: 'neofetch' no está instalado en tu sistema.\e[0m"
    echo -e "Por favor, instálalo antes de continuar:"
    echo -e "   \e[1;32msudo pacman -S neofetch\e[0m (en Arch Linux)"
    exit 1
fi

# Si no existe banner.txt, lo generamos por defecto con el nombre del Host
if [ ! -f "$DIR/banner.txt" ]; then
    echo -e "\e[1;34m[~] Detectando host y generando banner inicial...\e[0m"
    python3 "$DIR/generate_banner.py" --text "$(uname -n | tr 'a-z' 'A-Z')"
fi

# Ejecutar neofetch apuntando a nuestra configuración y banner personalizados
neofetch --config "$DIR/config.conf" --ascii "$DIR/banner.txt"
