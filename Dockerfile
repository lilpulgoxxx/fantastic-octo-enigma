FROM ollama/ollama:latest

ENV OLLAMA_HOST=0.0.0.0
ENV OLLAMA_ORIGINS=*
ENV OLLAMA_FLASH_ATTENTION=1
ENV OLLAMA_KEEP_ALIVE=-1
ENV OLLAMA_PORT=7860

USER root

# Instalar curl
RUN apt-get update && apt-get install -y curl

# Crear el directorio de trabajo
WORKDIR /app

# Copiar Modelfile
COPY Modelfile /app/

# Descargar el modelo
RUN curl -fsSL https://huggingface.co/bartowski/Llama-3.2-3B-Instruct-uncensored-GGUF/resolve/main/Llama-3.2-3B-Instruct-uncensored-Q2_K_L.gguf?download=true -o llama.gguf

# Exponer el puerto
EXPOSE 7860

#EXECUTE OLLAMA

RUN ollama serve & sleep 5 && ollama create llama -f Modelfile
