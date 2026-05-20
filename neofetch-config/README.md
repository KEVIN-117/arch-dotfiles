# 👾 Cyberpunk Neofetch - Alacritty & VM Optimized HUD

Una configuración premium de Neofetch ultra-simplificada, altamente compatible y optimizada específicamente para emuladores de terminal como **Alacritty** ejecutados sobre **ZSH** dentro de entornos emulados en **Máquinas Virtuales (VM)**.

Este diseño carga una imagen estática a todo color (**pixelArt.jpg**) utilizando la tecnología de conversión de imágenes por bloques ANSI **Chafa**, acompañada de un panel HUD con iconos geométricos y barras de progreso bajo la paleta de colores **Ghost Cyan (Ice Cold)**.

---

## ✨ Características Principales

1. **Optimización para Alacritty & VM (Chafa Backend)**: Alacritty y los entornos virtuales suelen carecer de soporte de aceleración gráfica para mostrar imágenes tradicionales (mediante `w3m` o `ueberzug`). Usamos **Chafa**, que procesa cualquier imagen real en bloques de caracteres ANSI a todo color en alta definición de forma matemática, garantizando un renderizado 100% perfecto, rápido y sin fallos de pantalla.
2. **Imagen Estática de Preferencia**: Cargamos de forma estática la espectacular imagen `images/pixelArt.jpg`, que encaja de forma perfecta con el look cian cibernético.
3. **Paleta Ghost Cyan**: Una paleta de colores fijos de alto contraste y estética futurista fría:
   * **Bordes y Etiquetas**: `51` (Cian brillante)
   * **Cabecera (Símbolo )**: `81` (Celeste)
   * **Valores de Información**: `7` (Blanco brillante de alta legibilidad y contraste)
4. **HUD Panel Simplificado**: Estructura minimalista y limpia encapsulada en cajas estéticas (`┌─┤├─┐`).
5. **Barras de Progreso Reales**: Monitoreo de CPU, RAM y Disco mediante bloques progresivos de carga (`██████░░░░`).
6. **Iconos Geométricos Cyber-Retro**: Iconografía limpia e integrada (`▲`, `⚃`, `♦`, `❖`, `▣`, `■`, `●`).

---

## 📁 Estructura de Archivos del Directorio

* [config.conf](file:///c:/Users/MSI%20CYBORG%2014/profile/repos/dotfiles/neofetch-config/config.conf): Configuración estática de Neofetch que contiene el diseño HUD, colores Ghost Cyan y la ruta a la imagen.
* [neofetch.sh](file:///c:/Users/MSI%20CYBORG%2014/profile/repos/dotfiles/neofetch-config/neofetch.sh): Lanzador minimalista en Bash encargado de ejecutar Neofetch.
* **images/**: Carpeta que contiene la imagen fija `pixelArt.jpg`.

---

## 🚀 Instrucciones de Uso

Sigue estos sencillos pasos en tu sistema Arch Linux dentro de tu VM:

### 1. Instalar Chafa (Prerrequisito esencial para Alacritty)
Para poder renderizar la imagen real en bloques de caracteres estéticos de alta definición, instala `chafa` en tu sistema:
```bash
sudo pacman -S chafa
```

### 2. Dar permisos de ejecución y probar
Asegúrate de que el script lanzador tenga permisos de ejecución:
```bash
chmod +x neofetch.sh
./neofetch.sh
```

---

## 💡 Consejo de Pro (ZSH integration)
Dado que usas **ZSH**, puedes crear una integración genial. Abre tu archivo `~/.zshrc` e integra el script para que se ejecute automáticamente cada vez que abras una nueva pestaña en tu terminal Alacritty:
```bash
# Agregar al final de ~/.zshrc
~/profile/repos/dotfiles/neofetch-config/neofetch.sh
```
¡Disfruta de tu espectacular entorno cyberpunk de alto contraste! 🦾🧊
