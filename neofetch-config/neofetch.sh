#!/usr/bin/env bash
# Wrapper ultra-simplificado para ejecutar Neofetch en Alacritty (VM)
# Utiliza la imagen fija 'pixelArt.jpg' con la tecnología de renderizado Chafa y el HUD de color Ghost Cyan.

# Obtener el directorio absoluto del script
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Verificar si neofetch está instalado
if ! command -v neofetch &> /dev/null; then
    echo -e "\e[1;31m[!] Error: 'neofetch' no está instalado en tu sistema.\e[0m"
    echo -e "Por favor, instálalo ejecutando:"
    echo -e "   \e[1;32msudo pacman -S neofetch\e[0m (en Arch Linux)"
    exit 1
fi

# Verificar si chafa está instalado para renderizar imágenes en Alacritty
if ! command -v chafa &> /dev/null; then
    echo -e "\e[1;33m[!] Nota: 'chafa' no está instalado. Para ver la imagen a todo color en Alacritty/VM, instálalo:\e[0m"
    echo -e "   \e[1;32msudo pacman -S chafa\e[0m (en Arch Linux)"
    echo -e "Mientras tanto, Neofetch se ejecutará con el logo de respaldo.\n"
fi

# Ejecutar Neofetch con nuestra configuración Ghost Cyan HUD y la imagen pixelArt.jpg estática
neofetch --config "$DIR/config.conf" --source "$DIR/images/pixelArt.jpg"