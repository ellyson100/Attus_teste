Explicação Dockerfile:

FROM node:14: Usa a imagem base do Node.js versão 14.
WORKDIR /usr/src/app: Define o diretório de trabalho dentro do contêiner.
COPY package.json ./*: Copia os arquivos package.json e package-lock.json para o diretório de trabalho.
RUN npm install: Instala as dependências definidas no package.json.
COPY . .: Copia todo o código da aplicação para o diretório de trabalho.
EXPOSE 3000: Exponha a porta 3000, que geralmente é a porta padrão para aplicações Node.js.
CMD ["npm", "start"]: Executa o comando npm start para iniciar a aplicação.

Explicação Docker Compose:

version: '3.8': Define a versão do Docker Compose.

services: Define os serviços que serão executados.

app:

build: .: Informa ao Docker Compose para construir a imagem usando o Dockerfile no diretório atual.
container_name: my_app: Define um nome para o contêiner da aplicação.
ports: Mapeia a porta 3000 do contêiner para a porta 3000 do host.
environment: Define variáveis de ambiente para o contêiner. Aqui configuramos a URL do MongoDB.
depends_on: Indica que o serviço app depende do serviço mongo.
mongo:

image: mongo:latest: Usa a última imagem do MongoDB disponível no Docker Hub.
container_name: my_mongo: Define um nome para o contêiner do banco de dados.
ports: Mapeia a porta 27017 do contêiner para a porta 27017 do host.
volumes: Define um volume para persistir os dados do MongoDB.
networks: Define a rede padrão como bridge, que é o tipo de rede padrão no Docker Compose.

volumes: Define um volume chamado mongo_data para persistir os dados do banco de dados MongoDB.

Explicação CI/CD:

name: CI/CD Pipeline: Nome do pipeline.

on: Define quando o pipeline deve ser executado (em push ou pull request para a branch escolhida).

jobs: Define os jobs que serão executados no pipeline.

build:
runs-on: ubuntu-latest: Define que o job deve ser executado em um ambiente Ubuntu.

steps: Define os passos do job:

Checkout repository: Usa a ação actions/checkout@v2 para fazer o checkout do repositório.
Set up Docker Buildx: Usa a ação docker/setup-buildx-action@v1 para configurar o Docker Buildx.
Log in to Docker Hub: Usa a ação docker/login-action@v1 para fazer login no Docker Hub usando variáveis de ambiente (secrets.DOCKER_HUB_USERNAME e secrets.DOCKER_HUB_ACCESS_TOKEN). Você precisa adicionar essas secrets no seu repositório GitHub como variavel.
Build Docker image: Constrói a imagem Docker da aplicação com o nome my_app:latest.
Run Docker container: Executa o contêiner da aplicação mapeando a porta 3000 do contêiner para a porta 3000 do host.
Wait for container to be ready: Aguarda 15 segundos para garantir que o contêiner esteja pronto.
Test application: Usa o curl para verificar se a página está sendo exibida corretamente. Se o curl falhar, o comando exit 1 faz com que o job falhe.
Stop and remove Docker container: Para e remove o contêiner da aplicação.




