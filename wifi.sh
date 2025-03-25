#!/bin/bash

while true; do
  # Mostrar la lista de dispositivos Wi-Fi
  echo "Dispositivos Wi-Fi disponibles:"
  iwctl device list

  # Solicitar al usuario que seleccione la interfaz
  read -p "Introduce el nombre de la interfaz Wi-Fi (ej: wlan0, wlan1): " interface

  # Verificar si la interfaz existe
  if iwctl device list | grep -q "$interface"; then
    break # Interfaz válida, salir del bucle
  else
    echo "Interfaz no válida. Inténtalo de nuevo."
  fi
done

while true; do
  # Mostrar las redes disponibles para la interfaz seleccionada
  iwctl station "$interface" scan
  iwctl station "$interface" get-networks

  # Solicitar el nombre de la red (SSID)
  read -p "Introduce el nombre de la red (SSID): " ssid

  # Verificar si la red existe
  if iwctl station "$interface" get-networks | grep -q "$ssid"; then
    break # SSID válido, salir del bucle
  else
    echo "SSID no válido. Inténtalo de nuevo."
  fi
done

# Solicitar la contraseña de la red
read -s -p "Introduce la contraseña de la red: " password
echo ""  # Añadir una nueva línea para la salida

# Iniciar iwctl y conectar a la red usando la interfaz seleccionada
iwctl << EOF
station "$interface" connect "$ssid"
$password
exit
EOF

# Verificar la conexión
if iwctl station "$interface" show | grep -q "Connected"; then
  echo "Conexión exitosa a $ssid en $interface"
else
  echo "Error al conectar a $ssid en $interface"
fi

