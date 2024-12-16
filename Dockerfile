FROM ollama/ollama:latest

# Instalar curl
RUN apt-get update && apt-get install -y curl

# Crear el directorio de trabajo
WORKDIR /app

# Copiar Modelfile
COPY Modelfile /app/

# Descargar el modelo
RUN curl -fsSL https://huggingface.co/bartowski/Llama-3.2-3B-Instruct-uncensored-GGUF/resolve/main/Llama-3.2-3B-Instruct-uncensored-Q2_K_L.gguf?download=true -o llama.gguf

RUN ollama serve & sleep 5 && ollama create llaxcxcxcxcxma -f Modelfile && ollama models

# Exponer el puerto
EXPOSE 11434
