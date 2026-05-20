# 👾 Cyberpunk Neofetch - Ghost Cyan & Random Wallpaper HUD

Una configuración premium de Neofetch ultra-simplificada y de estética hacker/cyberpunk. Este diseño renderiza una imagen aleatoria desde tu directorio `images/` en cada ejecución, acompañada de un panel HUD con iconos geométricos y barras de progreso bajo la paleta de colores **Ghost Cyan (Ice Cold)**.

---

## ✨ Características Principales

1. **Random Wallpaper Mode**: Cada vez que ejecutas `neofetch.sh`, selecciona automáticamente y de forma aleatoria una imagen del directorio `images/` para mostrarla como logo de la terminal.
2. **Paleta Ghost Cyan**: Una paleta de colores fijos de alto contraste y estética cian futurista:
   * **Bordes y Etiquetas**: `51` (Cian brillante)
   * **Cabecera (Símbolo )**: `81` (Celeste)
   * **Valores de Información**: `7` (Blanco brillante de alta legibilidad)
3. **HUD Panel Simplificado**: Estructura minimalista y limpia encapsulada en cajas estéticas (`┌─┤├─┐`).
4. **Barras de Progreso Reales**: Monitoreo de CPU, RAM y Disco mediante bloques progresivos de carga (`██████░░░░`).
5. **Iconos Geométricos Cyber-Retro**: Iconografía limpia e integrada (`▲`, `⚃`, `♦`, `❖`, `▣`, `■`, `●`) compatible con cualquier terminal sin requerir fuentes complejas.

---

## 📁 Estructura de Archivos del Directorio

* [config.conf](file:///c:/Users/MSI%20CYBORG%2014/profile/repos/dotfiles/neofetch-config/config.conf): Configuración estática de Neofetch que contiene el diseño HUD, colores Ghost Cyan y el mapeo de los módulos.
* [neofetch.sh](file:///c:/Users/MSI%20CYBORG%2014/profile/repos/dotfiles/neofetch-config/neofetch.sh): Lanzador minimalista en Bash encargado de seleccionar de forma aleatoria la imagen de la carpeta `images/` y ejecutar Neofetch.
* **images/**: Carpeta con tu repertorio de imágenes en formato `.jpg`, `.jpeg` o `.png`.

---

## 🚀 Instrucciones de Uso

Para empezar a utilizar tu HUD de Neofetch, sigue estos sencillos pasos:

### 1. Dar permisos de ejecución
Asegúrate de que el script lanzador tenga permisos de ejecución en Linux:
```bash
chmod +x neofetch.sh
```

### 2. Ejecutar tu Neofetch
Simplemente ejecuta el script wrapper desde la terminal:
```bash
./neofetch.sh
```

---

## 💡 Consejo de Pro
Puedes añadir un alias a tu archivo `.zshrc` o `.bashrc` para poder ejecutar esta belleza desde cualquier lugar de tu terminal al abrirla:
```bash
alias cyberfetch="~/profile/repos/dotfiles/neofetch-config/neofetch.sh"
```
¡Disfruta de tu nuevo entorno cyberpunk de alto contraste! 🦾🧊
