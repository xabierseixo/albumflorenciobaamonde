#!/usr/bin/env python3

from PIL import Image
import os

def resize_image(input_path, output_path, max_dimension=1200):
    """Redimensiona unha imaxe mantendo a proporción, cun tamaño máximo especificado."""
    try:
        with Image.open(input_path) as img:
            # Calcular as novas dimensións mantendo a proporción
            img.thumbnail((max_dimension, max_dimension), Image.Resampling.LANCZOS)
            
            # Gardar a imaxe redimensionada
            img.save(output_path, optimize=True, quality=85)
            
            # Obter información sobre a redución de tamaño
            original_size = os.path.getsize(input_path)
            new_size = os.path.getsize(output_path)
            reduction = int(100 - (new_size * 100 / original_size))
            
            print(f"✓ {os.path.basename(input_path)} -> Tamaño orixinal: {original_size/1024/1024:.2f}MB, "
                  f"Novo: {new_size/1024/1024:.2f}MB, Redución: {reduction}%")
            
    except Exception as e:
        print(f"✗ Erro ao procesar {input_path}: {str(e)}")

def main():
    print("Iniciando optimización das imaxes...")
    
    # Crear directorio para as imaxes optimizadas se non existe
    os.makedirs("/workspace/optimized_images", exist_ok=True)
    
    # Procesar cada imaxe
    for i in range(1, 75):
        input_path = f"/workspace/florencio{i:03d}.png"
        output_path = f"/workspace/optimized_images/florencio{i:03d}.png"
        
        if os.path.exists(input_path):
            print(f"Procesando florencio{i:03d}.png...")
            resize_image(input_path, output_path)
        else:
            print(f"⚠ Imaxe non atopada: {input_path}")
    
    print("\nOptimización completada!")
    print("Imaxes optimizadas gardadas en /workspace/optimized_images/")

if __name__ == "__main__":
    main()