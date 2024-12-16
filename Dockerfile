FROM ollama/ollama:latest

RUN apt-get update && apt-get install curl -y

RUN useradd -m -u 1000 user

USER user

ENV HOME=/home/user \
	PATH=/home/user/.local/bin:$PATH \
    OLLAMA_HOST=0.0.0.0

RUN mkdir /.ollama

WORKDIR $HOME/app

COPY --chown=user:user Modelfile $HOME/app/

RUN curl -fsSL https://huggingface.co/bartowski/Llama-3.2-3B-Instruct-uncensored-GGUF/resolve/main/Llama-3.2-3B-Instruct-uncensored-Q2_K_L.gguf?download=true -o llama.gguf

RUN ollama serve & sleep 5 && ollama create llama -f Modelfile

EXPOSE 11434
