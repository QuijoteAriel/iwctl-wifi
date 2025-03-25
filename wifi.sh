#!/bin/bash

# Mostrar la lista de dispositivos Wi-Fi
echo "Dispositivos Wi-Fi disponibles:"
iwctl device list

# Solicitar al usuario que seleccione la interfaz
read -p "Introduce el nombre de la interfaz Wi-Fi (ej: wlan0, wlan1): " interface

# Mostrar las redes disponibles para la interfaz seleccionada
iwctl station "$interface" scan
iwctl station "$interface" get-networks

# Solicitar el nombre de la red (SSID)
read -p "Introduce el nombre de la red (SSID): " ssid

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

