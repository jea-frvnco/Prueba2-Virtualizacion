FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Instalar dependencias necesarias
RUN apt-get update && apt-get install -y \
    apache2 \
    wget \
    build-essential \
    unzip \
    libgd-dev \
    libapache2-mod-php \
    php \
    php-gd \
    libssl-dev \
    daemon \
    curl \
    && apt-get clean

# Crear usuario y grupo nagios
RUN useradd nagios && \
    groupadd nagcmd && \
    usermod -a -G nagcmd nagios && \
    usermod -a -G nagcmd www-data

# Descargar y compilar Nagios Core
WORKDIR /tmp
RUN wget https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.4.6.tar.gz && \
    tar xzf nagios-4.4.6.tar.gz && \
    cd nagios-4.4.6 && \
    ./configure --with-command-group=nagcmd && \
    make all && \
    make install && \
    make install-init && \
    make install-commandmode && \
    make install-config && \
    make install-webconf && \
    rm -rf /tmp/nagios-*

# Configurar usuario web nagiosadmin
RUN htpasswd -bc /usr/local/nagios/etc/htpasswd.users nagiosadmin nagiosadmin

# Habilitar CGI en Apache
RUN a2enmod cgi

# Exponer el puerto 80
EXPOSE 80

# Comando de inicio
CMD ["sh", "-c", "apachectl start && /usr/local/nagios/bin/nagios /usr/local/nagios/etc/nagios.cfg && tail -f /var/log/apache2/access.log"]
