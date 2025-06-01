# 🐳 Nagios Core en Docker y Despliegue en AWS ECS

Este repositorio contiene un proyecto que implementa Nagios Core dentro de un contenedor Docker basado en Ubuntu 22.04. El objetivo es construir una imagen funcional de Nagios para monitoreo de servicios y sistemas, y desplegarla en Amazon ECS (Elastic Container Service), utilizando almacenamiento persistente con EFS (Elastic File System) y acceso a través de un Application Load Balancer (ALB).

## 📁 Archivos incluidos

- `Dockerfile`: Define la imagen Docker con Nagios Core.
- `start.sh`: Script que inicia Apache y Nagios, y mantiene el contenedor activo.
- `README.md`: Este archivo con la documentación y pasos de uso.

## ✅ Requisitos

- Docker instalado.
- Acceso a una instancia EC2 (Ubuntu 22.04).
- Clave `.pem` o `.ppk` para conexión SSH.
- Cuenta en AWS con permisos para usar ECR, ECS, EFS y ALB.
- Git (opcional para clonar el repositorio).

## 🛠️ Construcción y ejecución local

Clona el repositorio:

git clone https://github.com/<tu_usuario>/nagios-docker.git
cd nagios-docker

2.Da permisos al script de inicio:
chmod +x start.sh

3.Construye la imagen Docker:
docker build -t nagios-core .

4.Ejecuta el contenedor:
docker run -d -p 80:80 --name nagios nagios-core

5.Abre el navegador y accede a:
http://localhost
Credenciales de acceso:
Usuario: nagiosadmin
Contraseña: nagiosadmin

