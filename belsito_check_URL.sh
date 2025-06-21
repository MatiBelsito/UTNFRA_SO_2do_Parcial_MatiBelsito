#!/bin/bash

# Verificar si se pasó el archivo como argumento
if [ -z "$1" ]; then
    echo "Uso: $0 <ruta_al_archivo_de_URLs>"
    exit 1
fi

ARCHIVO="$1"

# Crear estructura de carpetas
mkdir -p /tmp/head-check/OK
mkdir -p /tmp/head-check/cliente
mkdir -p /tmp/head-check/servidor

# Archivo de log general
LOG_GENERAL="/var/log/status_URL.log"

# Leer cada línea del archivo de URLs
while read -r URL; do
    # Saltar líneas vacías
    [ -z "$URL" ] && continue

    # Obtener el código de estado HTTP
    STATUS_CODE=$(curl -LI -o /dev/null -w '%{http_code}\n' -s "$URL")

    # Obtener timestamp
    FECHA=$(date +%Y%m%d_%H%M%S)

    # Formar línea de log
    LINEA="$FECHA - Code:$STATUS_CODE - URL:$URL"

    # Registrar en log general
    echo "$LINEA" >> "$LOG_GENERAL"

    # Extraer dominio (tercer campo después de http[s]://)
    DOMINIO=$(echo "$URL" | cut -d/ -f3)

    # Decidir carpeta según código
    if [ "$STATUS_CODE" = "200" ]; then
        echo "$LINEA" >> "/tmp/head-check/OK/${DOMINIO}.log"
    elif [ "$STATUS_CODE" -ge 400 ] && [ "$STATUS_CODE" -le 499 ]; then
        echo "$LINEA" >> "/tmp/head-check/cliente/${DOMINIO}.log"
    elif [ "$STATUS_CODE" -ge 500 ] && [ "$STATUS_CODE" -le 599 ]; then
        echo "$LINEA" >> "/tmp/head-check/servidor/${DOMINIO}.log"
    fi

done < "$ARCHIVO"

