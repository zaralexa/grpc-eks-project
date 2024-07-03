# Utiliza la imagen oficial de Python desde Docker Hub
FROM python:3.8-slim

# Establece el directorio de trabajo en el contenedor
WORKDIR /app

# Copia el archivo de dependencias en el contenedor
COPY server/requirements.txt .

# Instala las dependencias especificadas en requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copia el resto del código del servidor en el contenedor
COPY server/ .

# Expone el puerto 50051 para gRPC
EXPOSE 50051

# Ejecuta el servidor
CMD ["python", "app.py"]
