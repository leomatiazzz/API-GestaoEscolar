# 1. Usa uma imagem base leve do Python com Alpine Linux
FROM python:3.13.4-alpine3.22

# 2. Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# 3. Copia o arquivo de dependências para o diretório de trabalho
# Isso aproveita o cache de camadas do Docker. Se o requirements.txt não mudar,
# o Docker não reinstalará as dependências a cada build.
COPY requirements.txt .

# 4. Instala as dependências do projeto
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copia todo o código da aplicação para o diretório de trabalho
COPY . .

# 6. Expõe a porta que a aplicação vai usar
EXPOSE 8000

# 7. Comando para iniciar a aplicação quando o contêiner for executado
# Usamos 0.0.0.0 para que a aplicação seja acessível de fora do contêiner
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
