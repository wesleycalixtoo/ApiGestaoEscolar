# 1. Imagem Base: Utiliza uma imagem Python estável e leve.
# O readme.md especifica Python 3.10+, então a `3.10-slim` é uma ótima escolha,
# pois oferece um bom equilíbrio entre tamanho e compatibilidade.
FROM python:3.10-slim

# 2. Variáveis de Ambiente: Define variáveis para boas práticas em contêineres.
# PYTHONDONTWRITEBYTECODE: Impede o Python de criar arquivos .pyc.
# PYTHONUNBUFFERED: Garante que os logs da aplicação sejam enviados diretamente para o terminal.
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# 3. Diretório de Trabalho: Define o diretório de trabalho dentro do contêiner.
WORKDIR /app

# 4. Copia e Instala as Dependências:
# Copiar o requirements.txt primeiro aproveita o cache de camadas do Docker.
# Se o arquivo não mudar, o Docker não reinstalará as dependências em builds futuros.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copia o Código da Aplicação: Copia o restante dos arquivos para o diretório de trabalho.
COPY . .

# 6. Expõe a Porta: Informa ao Docker que o contêiner escutará na porta 8000.
EXPOSE 8000

# 7. Comando de Execução: Define o comando para iniciar a aplicação com Uvicorn.
# O host `0.0.0.0` torna a aplicação acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
