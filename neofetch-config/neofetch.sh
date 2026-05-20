#!/usr/bin/env bash
# Wrapper para ejecutar Neofetch con temática Cyberpunk Ghost Cyan
# Renderiza un logotipo de ARCH personalizado en formato ASCII con degradado y un HUD de recursos de alta legibilidad.

# Obtener el directorio absoluto del script
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Verificar si neofetch está instalado
if ! command -v neofetch &> /dev/null; then
    echo -e "\e[1;31m[!] Error: 'neofetch' no está instalado en tu sistema.\e[0m"
    echo -e "Por favor, instálalo ejecutando:"
    echo -e "   \e[1;32msudo pacman -S neofetch\e[0m (en Arch Linux)"
    exit 1
fi

# Ejecutar Neofetch con nuestra configuración HUD y el banner de ARCH personalizado
neofetch --config "$DIR/config.conf" --ascii "$DIR/arch_ascii.txt"
