#!/bin/bash

# Crear directorios de logs si no existen
[ ! -d /var/log/apache2 ] && mkdir -p /var/log/apache2
[ ! -f /var/log/apache2/access.log ] && touch /var/log/apache2/access.log

# Verificar si el binario de Nagios existe
if [ ! -f /usr/local/nagios/bin/nagios ]; then
  echo "❌ Error: Nagios no está instalado en /usr/local/nagios/bin/nagios"
  exit 1
fi

# Verificar si el archivo de configuración existe
if [ ! -f /usr/local/nagios/etc/nagios.cfg ]; then
  echo "❌ Error: Archivo de configuración de Nagios no encontrado."
  exit 1
fi

# Iniciar Apache en segundo plano
echo "🔄 Iniciando Apache..."
apachectl start

# Iniciar Nagios
echo "✅ Iniciando Nagios..."
/usr/local/nagios/bin/nagios /usr/local/nagios/etc/nagios.cfg

# Mantener contenedor corriendo
echo "📡 Mostrando logs de Apache:"
tail -f /var/log/apache2/access.log
