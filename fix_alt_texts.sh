#!/bin/bash

INPUT_FILE="/workspace/florencio.html"

# Array cos nomes de imaxes
images=($(seq -f "florencio%03g.png" 1 74))

# Contador de páxinas
page_num=1

for img in "${images[@]}"; do
    sed -i "s|src=\"$img\" alt=\"Portada\"|src=\"$img\" alt=\"Portada\"|g" "$INPUT_FILE"  # Non cambiamos a portada
    sed -i "s|src=\"$img\" alt=\"Páxina\"|src=\"$img\" alt=\"Páxina $page_num\"|g" "$INPUT_FILE"
    sed -i "s|src=\"$img\" alt=\"Páxina $page_num\"|src=\"$img\" alt=\"Páxina $page_num\"|g" "$INPUT_FILE"  # Xa está ben
    ((page_num++))
done