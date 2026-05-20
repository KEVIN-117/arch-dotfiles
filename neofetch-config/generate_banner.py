#!/usr/bin/env python3
import os
import sys
import argparse

def install_pillow_prompt():
    print("\033[1;33m[!] Advertencia: La biblioteca 'Pillow' (PIL) no está instalada.\033[0m")
    print("Para renderizar la fuente 'Dune Rise' en tu terminal, necesitas instalarla.")
    print("Puedes hacerlo ejecutando:")
    print("    \033[1;32mpip install pillow\033[0m  O  \033[1;32mpacman -S python-pillow\033[0m (en Arch Linux)")
    print("\nUsando banner de respaldo estilo hacker...")

# Fallback ASCII banners for common text if Pillow is not available
FALLBACK_BANNERS = {
    "ARCH": r"""
\033[1;32m      ___           ___           ___       ___       ___     
     /\  \         /\  \         /\  \     /\__\     /\__\    
    /::\  \       /::\  \       /::\  \   /:/__/_   /:/  /    
   /:/\:\  \     /:/\:\  \     /:/\:\__\ /::\/\__\ /:/__/     
  /::\~\:\  \   /::\~\:\  \   /:/  /  /  \/\::/  / \/::\  \   
 /:/\:\ \:\__\ /:/\:\ \:\__\ /:/__/  /     /:/  /    \:::\__\ 
 \/__\:\/:/  / \/_|::\/:/  / \:\  \  /      \/__/      \::/  / 
      \::/  /     |:|::/  /   \:\  \/                /:/  /  
      /:/  /      |:|\/__/     \:\  /               /:/  /   
     /:/  /       |:|  |        \:\__\              \/__/    
     \/__/         \|__|         \/__/                       \033[0m
""",
    "HACKER": r"""
\033[1;35m ___  ___  ________  ________  ___  __    _______   ________     
|_  ||_  ||_   __  ||_   ___  ||_  |/ /   |_   __ \ |_   __  |    
  | |_/ /   | |_ \_|  | |_  \_|  | ' /      | |__) |  | |_ \_|    
  |  __'.   |  _| _   | |        |  <       |  __ /   |  _| _     
 _| |  \ \_| |_/___| _| |_      _| |  \ \  _| |  \ \_| |_/___|    
|____| |___|________|________| |____| |___|____| |___|________|   \033[0m
"""
}

def get_fallback_banner(text, color_ansi="32"):
    clean_text = text.upper().strip()
    if clean_text in FALLBACK_BANNERS:
        banner = FALLBACK_BANNERS[clean_text]
    else:
        # Generic block-styled letters fallback for other words
        # If not in our list, we'll draw a nice cyber frame around the text
        banner = f"\033[1;{color_ansi}m"
        banner += " ── " + "─" * len(text) + " ──\n"
        banner += f" ──  {text}  ──\n"
        banner += " ── " + "─" * len(text) + " ──"
        banner += "\033[0m\n"
    
    return banner.replace("\\033", "\x1b").replace("\\e", "\x1b")

def generate_banner(text, font_path, output_path, color_ansi="32", font_size=32):
    try:
        from PIL import Image, ImageDraw, ImageFont
    except ImportError:
        install_pillow_prompt()
        fallback = get_fallback_banner(text, color_ansi)
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write(fallback)
        return False

    if not os.path.exists(font_path):
        print(f"\033[1;31m[!] Error: No se encontró la fuente en {font_path}\033[0m")
        fallback = get_fallback_banner(text, color_ansi)
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write(fallback)
        return False

    # 1. Render text in high-res black & white
    try:
        # Load custom TTF font
        # Dune Rise is a very wide font, so font size 24-32 is usually good
        font = ImageFont.truetype(font_path, font_size)
    except Exception as e:
        print(f"\033[1;31m[!] Error cargando fuente: {e}\033[0m")
        fallback = get_fallback_banner(text, color_ansi)
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write(fallback)
        return False

    # Get size of text to create the image canvas
    # Using font.getbbox (modern pillow)
    bbox = font.getbbox(text)
    w = bbox[2] - bbox[0] + 10
    h = bbox[3] - bbox[1] + 10

    # Create grayscale image and draw text
    img = Image.new("L", (w, h), 0)
    draw = ImageDraw.Draw(img)
    draw.text((5 - bbox[0], 5 - bbox[1]), text, fill=255, font=font)

    # 2. Downsample for terminal
    # Standard terminal characters have a roughly 1:2 aspect ratio (width:height)
    # Since we are using half-block characters (1 char = 2 vertical pixels),
    # the downsampled pixel grid should map 1:1 to terminal character grid for crisp pixels!
    # Let's set a target width for the banner (e.g. 45 characters max to fit neofetch sidebar)
    target_width = 45
    if w > target_width:
        aspect = h / w
        new_w = target_width
        new_h = int(target_width * aspect)
    else:
        new_w = w
        new_h = h

    # Make sure height is even for the vertical pixel pairing
    if new_h % 2 != 0:
        new_h += 1

    if new_w <= 0 or new_h <= 0:
        new_w = 40
        new_h = 10

    img_resized = img.resize((new_w, new_h), Image.Resampling.LANCZOS)
    pixels = img_resized.load()

    # 3. Convert to half-block Unicode ANSI
    # Top pixel = y, Bottom pixel = y+1
    ansi_lines = []
    
    # We construct the ANSI color prefix
    color_prefix = f"\033[38;5;{color_ansi}m" if color_ansi.isdigit() else f"\033[{color_ansi}m"
    ansi_reset = "\033[0m"

    for y in range(0, new_h, 2):
        line_chars = []
        has_colored_pixels = False
        for x in range(new_w):
            top_val = pixels[x, y]
            bottom_val = pixels[x, y+1]
            
            # Threshold to decide if pixel is filled (127/255)
            top_active = top_val > 127
            bottom_active = bottom_val > 127

            if top_active and bottom_active:
                line_chars.append("█")
                has_colored_pixels = True
            elif top_active and not bottom_active:
                line_chars.append("▀")
                has_colored_pixels = True
            elif not top_active and bottom_active:
                line_chars.append("▄")
                has_colored_pixels = True
            else:
                line_chars.append(" ")
        
        # Trim trailing spaces to save terminal space and render correctly
        line_str = "".join(line_chars).rstrip()
        if line_str:
            ansi_lines.append(f"{color_prefix}{line_str}{ansi_reset}")
        else:
            ansi_lines.append("")

    # Remove leading/trailing empty lines
    while ansi_lines and not ansi_lines[0]:
        ansi_lines.pop(0)
    while ansi_lines and not ansi_lines[-1]:
        ansi_lines.pop()

    # Save to file
    banner_content = "\n".join(ansi_lines) + "\n"
    # Reemplazar secuencias literales como \033 o \e por bytes de escape reales para que los colores funcionen en Neofetch
    banner_content = banner_content.replace("\\033", "\x1b").replace("\\e", "\x1b")
    
    with open(output_path, 'w', encoding='utf-8') as f:
        f.write(banner_content)

    print(f"\033[1;32m[+] Banner generado con éxito en: {output_path}\033[0m")
    return True

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Generador de banners Dune Rise para Neofetch")
    parser.add_argument("--text", type=str, default="ARCH", help="Texto del banner")
    parser.add_argument("--font", type=str, default="../misc/fonts/Dune_Rise.ttf", help="Ruta de la fuente TTF")
    parser.add_argument("--output", type=str, default="banner.txt", help="Ruta del archivo de salida")
    parser.add_argument("--color", type=str, default="82", help="Código de color ANSI (ej. 82 para verde neón, 198 para morado)")
    parser.add_argument("--size", type=int, default=32, help="Tamaño de fuente para renderizado")
    
    args = parser.parse_args()

    # Resolve paths absolute to avoid working directory issues
    base_dir = os.path.dirname(os.path.abspath(__file__))
    
    font_path = args.font
    if not os.path.isabs(font_path):
        font_path = os.path.abspath(os.path.join(base_dir, font_path))
        
    output_path = args.output
    if not os.path.isabs(output_path):
        output_path = os.path.abspath(os.path.join(base_dir, output_path))

    generate_banner(args.text, font_path, output_path, args.color, args.size)
