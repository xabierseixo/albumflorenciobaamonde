#!/bin/bash

# Script para actualizar todas as seccións do arquivo florencio.html

INPUT_FILE="/workspace/florencio.html"
TEMP_FILE="/workspace/florencio_temp.html"

cp "$INPUT_FILE" "$TEMP_FILE"

# Array cos nomes de imaxes
images=($(seq -f "florencio%03g.png" 5 74))

# Contador de páxinas
page_num=5

for img in "${images[@]}"; do
    # Escapar caracteres especiais para sed
    IMG_ESCAPED=$(echo "$img" | sed 's/\//\\\//g')
    
    # Substituír a sección correspondente
    sed -i "s|<!-- Páxina $page_num -->\n<section style=\"background-image: url('$IMG_ESCAPED');\">\(.*\)</section>|<!-- Páxina $page_num -->\n<div class=\"page-container\">\n  <img src=\"$img\" alt=\"Páxina $page_num\" class=\"image-background\">\1</div>|g" "$TEMP_FILE"
    
    # Para seccións que teñen só imaxe
    sed -i "s|<!-- Páxina $page_num (só imaxe) -->\n<section style=\"background-image: url('$IMG_ESCAPED');\"></section>|<!-- Páxina $page_num (só imaxe) -->\n<div class=\"page-container\">\n  <img src=\"$img\" alt=\"Páxina $page_num\" class=\"image-background\">\n</div>|g" "$TEMP_FILE"
    
    ((page_num++))
done

# Substituír a última páxina que ten un formato especial
sed -i 's|<!-- Páxina 74 -->\n<section style="background-image: url.*">\(.*\)</section>|<!-- Páxina 74 -->\n<div class="page-container">\n  <img src="florencio074.png" alt="Páxina 74" class="image-background">\1</div>|g' "$TEMP_FILE"

mv "$TEMP_FILE" "$INPUT_FILE"