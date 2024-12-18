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

# Copiar Modelfiles
COPY Modelfile-* /app/

# Descargar los modelos
RUN curl -fsSL https://huggingface.co/bartowski/Llama-3.2-3B-Instruct-uncensored-GGUF/resolve/main/Llama-3.2-3B-Instruct-uncensored-Q2_K_L.gguf?download=true -o llama.gguf && \
    curl -fsSL https://huggingface.co/Hjgugugjhuhjggg/testing_semifinal-Q2_K-GGUF/resolve/main/testing_semifinal-q2_k.gguf?download=true -o testing_semifinal.gguf && \
    curl -fsSL https://huggingface.co/DevQuasar/CohereForAI.c4ai-command-r7b-12-2024-GGUF/resolve/main/CohereForAI.c4ai-command-r7b-12-2024.Q2_K.gguf?download=true -o cohere.gguf && \
    curl -fsSL https://huggingface.co/bartowski/Llama-3.3-70B-Instruct-GGUF/resolve/main/Llama-3.3-70B-Instruct-IQ1_M.gguf?download=true -o llama70b.gguf

# Exponer el puerto
EXPOSE 7860

# Ejecutar Ollama y crear los modelos
RUN ollama serve & sleep 5 && \
    ollama create llama -f Modelfile-llama && \
    ollama create testing -f Modelfile-testing && \
    ollama create cohere -f Modelfile-cohere && \
    ollama create llama70b -f Modelfile-llama70b
