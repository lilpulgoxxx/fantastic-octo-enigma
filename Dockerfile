FROM ollama/ollama:latest

ENV OLLAMA_HOST=0.0.0.0
ENV OLLAMA_ORIGINS=*
ENV OLLAMA_FLASH_ATTENTION=1
ENV OLLAMA_KEEP_ALIVE=-1
ENV OLLAMA_PORT=7860

USER root

# Install curl and wget (more versatile for downloads)
RUN apt-get update && apt-get install -y --no-install-recommends curl wget && rm -rf /var/lib/apt/lists/*

# Create the working directory
WORKDIR /app

# Copy Modelfiles
COPY Modelfile-* /app/

# Download models in parallel
RUN wget -q https://huggingface.co/bartowski/Llama-3.2-3B-Instruct-uncensored-GGUF/resolve/main/Llama-3.2-3B-Instruct-uncensored-Q2_K_L.gguf -O llama.gguf & \
    wget -q https://huggingface.co/Hjgugugjhuhjggg/testing_semifinal-Q2_K-GGUF/resolve/main/testing_semifinal-q2_k.gguf -O testing_semifinal.gguf & \
    wget -q https://huggingface.co/DevQuasar/CohereForAI.c4ai-command-r7b-12-2024-GGUF/resolve/main/CohereForAI.c4ai-command-r7b-12-2024.Q2_K.gguf -O cohere.gguf & \
    wget -q https://huggingface.co/bartowski/Llama-3.3-70B-Instruct-GGUF/resolve/main/Llama-3.3-70B-Instruct-IQ1_M.gguf -O llama70b.gguf & \
    wget -q https://huggingface.co/bartowski/QwQ-32B-Preview-GGUF/raw/main/QwQ-32B-Preview-IQ2_M.gguf -O qwq.gguf & \
    wget -q https://huggingface.co/tensorblock/llama-3.2-1B-spinquant-hf-GGUF/resolve/main/llama-3.2-1B-spinquant-hf-Q2_K.gguf -O llama1b.gguf & \
    wait

# Expose the port
EXPOSE 7860

# Start Ollama and create models
RUN ollama serve & sleep 5 && ollama create llama -f Modelfile-llama && ollama create testing -f Modelfile-testing && ollama create cohere -f Modelfile-cohere && ollama create llama70b -f Modelfile-llama70b && ollama create qwq -f Modelfile-qwq && ollama create llama1b -f Modelfile-llama1b
