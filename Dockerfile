FROM ollama/ollama:latest

# Instalar curl
RUN apt-get update && apt-get install -y curl

# Crear el usuario
RUN useradd -m -u 1000 user

# Cambiar al usuario creado
USER user

# Definir variables de entorno
ENV HOME=/home/user \
    PATH=/home/user/.local/bin:$PATH \
    OLLAMA_HOST=0.0.0.0 \
    OLLAMA_HOME=/home/user/.ollama  # Cambiar la ubicación del directorio .ollama

# Crear el directorio de trabajo
WORKDIR $HOME/app

# Copiar Modelfile
COPY --chown=user:user Modelfile $HOME/app/

# Descargar el modelo
RUN curl -fsSL https://huggingface.co/bartowski/Llama-3.2-3B-Instruct-uncensored-GGUF/resolve/main/Llama-3.2-3B-Instruct-uncensored-Q2_K_L.gguf?download=true -o llama.gguf

# Crear el modelo con Ollama
RUN ollama serve & sleep 5 && ollama create llama -f Modelfile

# Exponer el puerto
EXPOSE 11434
