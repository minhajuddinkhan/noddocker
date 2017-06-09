
#Pull Nodejs
FROM node:argon

#Make a dir for source code
RUN mkdir /app

#Set working dir
WORKDIR /app

#Copy package.json to source 

COPY package.json /app

# install dependencies
RUN npm install  

# copy modules to source
COPY . /app

# Bind port to external network
EXPOSE 3000

# Let the hunger games begin
CMD ["npm", "start"]
