#!/bin/bash

echo "Iniciando optimización das imaxes..."

# Crear directorio para as imaxes optimizadas se non existe
mkdir -p /workspace/optimized_images

# Redimensionar as imaxes (máximo 1200px de ancho/altura, manter proporción)
for i in {001..074}; do
  echo "Procesando florencio${i}.png..."
  convert-im6.q16 "/workspace/florencio${i}.png" -resize 1200x1200\> "/workspace/optimized_images/florencio${i}.png"
  if [ $? -eq 0 ]; then
    echo "  ✓ Imaxe florencio${i}.png optimizada"
    # Comprobar tamaños antes e despois
    original_size=$(stat -c%s "/workspace/florencio${i}.png")
    optimized_size=$(stat -c%s "/workspace/optimized_images/florencio${i}.png")
    reduction=$((100 - (optimized_size * 100 / original_size)))
    echo "  Tamaño orixinal: $(printf "%.2f" $(echo "$original_size/1024/1024" | bc)) MB"
    echo "  Tamaño optimizado: $(printf "%.2f" $(echo "$optimized_size/1024/1024" | bc)) MB"
    echo "  Redución: ${reduction}%"
  else
    echo "  ✗ Erro ao procesar florencio${i}.png"
  fi
done

echo "Optimización completada!"
echo "Imaxes optimizadas gardadas en /workspace/optimized_images/"