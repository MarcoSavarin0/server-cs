#!/bin/bash

update_cs() {
    ./steamcmd.sh +force_install_dir ./cstrike +login anonymous  +app_update 90 validate +quit
}
i=0
max_attempts=10
while [ $i -lt $max_attempts ]; do
    echo "Intento de actualización $((i+1))"
    update_cs
    exit_code=$?
    if [ $exit_code -eq 0 ]; then
        echo "Actualización exitosa."
        break
    else
        echo "Error en la actualización. Intentando nuevamente..."
    fi
    i=$((i+1))
done

if [ $i -eq $max_attempts ]; then
    echo "No se pudo actualizar después de $max_attempts intentos. Revisar manualmente."
fi
