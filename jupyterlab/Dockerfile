FROM jupyter/datascience-notebook:latest

# Usar usuario root para instalar paquetes adicionales
USER root

# Copiar el archivo requirements.txt al contenedor e instalar las dependencias
COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt

# Recuperar el usuario predeterminado configurado en la imagen (NB_UID suele estar definido en jupyter base images)
USER ${NB_UID}

# Establecer el directorio de trabajo (aquí es donde estarán tus notebooks)
WORKDIR /home/jovyan/work

# Exponer el puerto 8888 para JupyterLab
EXPOSE 8888

# Comando para arrancar JupyterLab
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--no-browser", "--allow-root"]

