# Use uma imagem Python oficial como imagem base.
# O README recomenda Python 3.10 ou superior. A variante -slim é uma boa escolha para produção.
FROM python:3.10-slim

# Defina o diretório de trabalho no contêiner
WORKDIR /app

# Copie o arquivo de dependências para o diretório de trabalho
# Isso aproveita o cache de camadas do Docker. Esta camada só será reconstruída se o requirements.txt mudar.
COPY requirements.txt .

# Instale as dependências
# A flag --no-cache-dir reduz o tamanho da imagem final.
RUN pip install --no-cache-dir -r requirements.txt

# Copie o restante do código da aplicação para o diretório de trabalho
COPY . .

# Exponha a porta 8000 para o mundo fora deste contêiner
EXPOSE 8000

# Comando para executar a aplicação quando o contêiner for iniciado
# Use 0.0.0.0 para tornar o servidor acessível de fora do contêiner.
# A flag --reload é para desenvolvimento, então a removemos para uma imagem de produção.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]