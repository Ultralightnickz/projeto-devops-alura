FROM python:3.13.4-alpine3.22

# Define o diretório de trabalho dentro do container.
WORKDIR /app

# Copia o arquivo de dependências primeiro para aproveitar o cache do Docker.
COPY requirements.txt .

# Instala as dependências. O --no-cache-dir reduz o tamanho da imagem.
RUN pip install --no-cache-dir -r requirements.txt
# aqui usamos o no-cache-dir para ele não guardar nada em cache, sempre que rodar o container 
# ele ira puxar tudo do zero

# Copia o restante do código da aplicação.
COPY . .

# Expõe a porta que a aplicação vai usar.
EXPOSE 8000

# Comando para iniciar a aplicação com Uvicorn.
# O host 0.0.0.0 permite que a aplicação seja acessível de fora do container.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
