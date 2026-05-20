# 👾 Cyberpunk Neofetch - Ghost Cyan & ARCH Graffiti HUD

Una configuración premium de Neofetch ultra-simplificada, altamente compatible y de estética hacker/cyberpunk. Este diseño utiliza un **logotipo de ARCH personalizado en formato ASCII de estilo Graffiti** con un hermoso degradado de color, acompañado de un panel HUD con iconos geométricos y barras de progreso bajo la paleta de colores **Ghost Cyan (Ice Cold)**.

---

## ✨ Características Principales

1. **ARCH Graffiti Logo**: Integra el arte ASCII solicitado para ARCH con un hermoso degradado dinámico de colores Ghost Cyan:
   * **Parte Superior**: `81` (Celeste)
   * **Parte Central**: `51` (Cian brillante)
   * **Parte Inferior**: `14` y `6` (Cian claro y cian estándar)
2. **Paleta Ghost Cyan**: Una paleta de colores fijos de alto contraste y estética futurista fría:
   * **Bordes y Etiquetas**: `51` (Cian brillante)
   * **Cabecera (Símbolo )**: `81` (Celeste)
   * **Valores de Información**: `7` (Blanco brillante de alta legibilidad y contraste)
3. **HUD Panel Simplificado**: Estructura minimalista y limpia encapsulada en cajas estéticas (`┌─┤├─┐`).
4. **Barras de Progreso Reales**: Monitoreo de CPU, RAM y Disco mediante bloques progresivos de carga (`██████░░░░`).
5. **Iconos Geométricos Cyber-Retro**: Iconografía limpia e integrada (`▲`, `⚃`, `♦`, `❖`, `▣`, `■`, `●`) compatible con cualquier terminal.

---

## 📁 Estructura de Archivos del Directorio

* [config.conf](file:///c:/Users/MSI%20CYBORG%2014/profile/repos/dotfiles/neofetch-config/config.conf): Configuración estática de Neofetch que contiene el diseño HUD, colores Ghost Cyan y el mapeo de los módulos.
* [arch_ascii.txt](file:///c:/Users/MSI%20CYBORG%2014/profile/repos/dotfiles/neofetch-config/arch_ascii.txt): Archivo de texto que almacena el banner ASCII personalizado de ARCH en colores degradados.
* [neofetch.sh](file:///c:/Users/MSI%20CYBORG%2014/profile/repos/dotfiles/neofetch-config/neofetch.sh): Lanzador minimalista en Bash encargado de ejecutar Neofetch con esta configuración.

---

## 🚀 Instrucciones de Uso

Para empezar a utilizar tu HUD de Neofetch, sigue estos sencillos pasos:

### 1. Dar permisos de ejecución
Asegúrate de que el script lanzador tenga permisos de ejecución en Linux:
```bash
chmod +x neofetch.sh
```

### 2. Ejecutar tu Neofetch
Simplemente ejecuta el script wrapper desde tu terminal:
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
