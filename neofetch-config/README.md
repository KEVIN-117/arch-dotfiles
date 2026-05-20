# 👾 Cyberpunk Neofetch Customizer & HUD

Una configuración premium de Neofetch altamente customizable, diseñada con estética hacker y cyberpunk. Cuenta con un **generador dinámico de banners** que utiliza la fuente **Dune Rise** (`Dune_Rise.ttf`) para renderizar títulos directamente en bloques ANSI de alta fidelidad en tu terminal, junto con un panel HUD con iconos Nerd Font y barras de progreso para tus recursos de hardware.

---

## ✨ Características Principales

1. **Dune Rise Font Renderer**: Convierte cualquier texto (tu nombre de usuario, host o palabra personalizada) en un banner de texto ASCII pixel-art renderizado en alta fidelidad con tu tipografía `Dune_Rise.ttf`.
2. **Interactive CLI Customizer**: Un script interactivo (`customize.py`) para configurar colores, nombres y el título del banner al instante sin tocar código.
3. **HUD Panel Estilo Hacker**: Estructura limpia y encapsulada del estado del sistema, con separadores estéticos (`┌─┤├─┐`).
4. **Barras de Progreso Reales**: Monitoreo de CPU, RAM, Disco y Batería mediante bloques progresivos de carga (`██████░░░░`) en lugar de texto simple.
5. **Nerd Font Icons**: Iconografía integrada y moderna compatible con cualquier tipografía Nerd Font (como las provistas en la carpeta `misc/fonts`).
6. **5 Temas Hacker Predefinidos**:
   * 🟢 **Toxic Green**: El clásico estilo verde terminal de Matrix.
   * 🟣 **Cyberpunk Neon**: Contraste vibrante de Rosa Neón y Cian.
   * 🔴 **Blood Red**: Estética oscura, agresiva y de red profunda en rojo vivo.
   * 🔵 **Ghost Cyan**: Diseño futurista frío estilo hielo.
   * 🟡 **Sunset Gold**: Panel en ámbar dorado con toques naranja cálido.

---

## 🛠️ Requisitos de Instalación

Asegúrate de contar con las siguientes herramientas en tu sistema (el entorno Arch Linux configurado en tus dotfiles ya cuenta con la mayoría):

1. **Neofetch**: La herramienta base de información.
   ```bash
   sudo pacman -S neofetch
   ```
2. **Python & Pillow** (Recomendado para renderizar la fuente Dune Rise):
   ```bash
   sudo pacman -S python-pillow
   # O alternativamente usando pip:
   pip install pillow
   ```
   *Nota: Si Pillow no está instalado, los scripts funcionarán de todas formas utilizando elegantes banners de respaldo.*
3. **Nerd Fonts**: Se recomienda una tipografía Nerd Font en tu terminal (como *Iosevka*, *Cozette* o *Meslo* presentes en tu carpeta `misc/fonts/`) para ver correctamente los iconos.

---

## 🚀 Instrucciones de Uso

Para empezar a utilizar y personalizar tu HUD de Neofetch, sigue estos sencillos pasos:

### 1. Dar permisos de ejecución
Asegúrate de que los scripts tengan permisos de ejecución. Abre tu terminal en este directorio y ejecuta:
```bash
chmod +x customize.py neofetch.sh
```

### 2. Iniciar el Personalizador Interactivo
Ejecuta el script de personalización. Te guiará paso a paso para configurar tu HUD a tu gusto:
```bash
./customize.py
```
Aquí podrás:
* Escribir el texto que quieres renderizar con la fuente **Dune Rise** (ej: `ARCH`, `HACKER`, tu nick, etc.).
* Escribir el título que se mostrará en la cabecera del panel.
* Seleccionar una de las 5 paletas de colores hacker.
* Probar el resultado inmediatamente en la terminal.

### 3. Ejecutar tu Neofetch Personalizado
Cuando quieras ver tu HUD de Neofetch en cualquier momento, simplemente ejecuta el script wrapper:
```bash
./neofetch.sh
```

---

## 📁 Estructura del Directorio

* [config.conf](file:///c:/Users/MSI%20CYBORG%2014/profile/repos/dotfiles/neofetch-config/config.conf): Configuración generada que lee Neofetch. Contiene el diseño y los colores del HUD.
* [generate_banner.py](file:///c:/Users/MSI%20CYBORG%2014/profile/repos/dotfiles/neofetch-config/generate_banner.py): Motor de renderizado en Python para convertir `Dune_Rise.ttf` a bloques Unicode ANSI.
* [banner.txt](file:///c:/Users/MSI%20CYBORG%2014/profile/repos/dotfiles/neofetch-config/banner.txt): Archivo de texto que almacena el banner ASCII generado actualmente.
* [customize.py](file:///c:/Users/MSI%20CYBORG%2014/profile/repos/dotfiles/neofetch-config/customize.py): Interfaz interactiva CLI para personalizarlo todo.
* [neofetch.sh](file:///c:/Users/MSI%20CYBORG%2014/profile/repos/dotfiles/neofetch-config/neofetch.sh): Lanzador cómodo para ejecutar Neofetch con tu diseño.

---

## 💡 Consejo de Pro
Puedes añadir un alias a tu archivo `.zshrc` o `.bashrc` para poder ejecutar esta belleza desde cualquier lugar de tu terminal:
```bash
alias cyberfetch="~/profile/repos/dotfiles/neofetch-config/neofetch.sh"
```
¡Disfruta de tu nuevo entorno hacker! 🦾🤖
