# Script de Conexión Wi-Fi con iwctl

Este script de bash automatiza el proceso de conexión a una red Wi-Fi utilizando la utilidad `iwctl`.

## Requisitos

* `iwctl` instalado en tu sistema.

## Uso

1.  Guarda el script en un archivo, por ejemplo, `wifi.sh`.
2.  Dale permisos de ejecución al script: `chmod +x wifi.sh`.
3.  Ejecuta el script: `./wifi.sh`.
4.  El script te guiará a través del proceso de selección de la interfaz Wi-Fi, la red (SSID) y la contraseña.

## Descripción del Script

1.  **Lista de Dispositivos Wi-Fi:**
    * El script comienza mostrando una lista de los dispositivos Wi-Fi disponibles usando `iwctl device list`.
2.  **Selección de Interfaz:**
    * Se solicita al usuario que introduzca el nombre de la interfaz Wi-Fi que desea utilizar (por ejemplo, `wlan0`).
3.  **Lista de Redes Disponibles:**
    * El script escanea y muestra las redes Wi-Fi disponibles para la interfaz seleccionada usando `iwctl station "$interface" scan` y `iwctl station "$interface" get-networks`.
4.  **Entrada de SSID y Contraseña:**
    * Se solicita al usuario que introduzca el nombre de la red (SSID) y la contraseña.
5.  **Conexión a la Red:**
    * El script utiliza `iwctl` para conectar a la red especificada con la contraseña proporcionada.
6.  **Verificación de Conexión:**
    * Después de intentar la conexión, el script verifica si la conexión fue exitosa y muestra un mensaje apropiado.

## Notas

* El script utiliza `read -s` para solicitar la contraseña, lo que evita que se muestre en la pantalla por seguridad.
* `iwctl` es una utilidad de linea de comandos para administrar conexiones inalambricas, comunmente usada en sistemas linux que utilizan "iwd" como demonio de conexión inalambrica.

## Ejemplo de Uso

```bash
Dispositivos Wi-Fi disponibles:
...
Introduce el nombre de la interfaz Wi-Fi (ej: wlan0, wlan1): wlan0
...
Introduce el nombre de la red (SSID): MiRedWifi
Introduce la contraseña de la red:
Conexión exitosa a MiRedWifi en wlan0
