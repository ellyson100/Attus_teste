# Use uma imagem base adequada
FROM node:14

# Crie um diretório de trabalho para a aplicação
WORKDIR /usr/src/app

# Copie o package.json e package-lock.json para o diretório de trabalho
COPY package*.json ./

# Instale as dependências da aplicação
RUN npm install

# Copie o código da aplicação para o diretório de trabalho
COPY . .

# Exponha a porta necessária (por exemplo, 3000)
EXPOSE 3000

# Execute a aplicação
CMD ["npm", "start"]
