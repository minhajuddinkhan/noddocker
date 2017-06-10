
<div style="text-align:right"><img src ="https://www.statusq.org/wp-content/uploads/2014/06/fbbb494a7eef5f9278c6967b6072ca3e.png" /></div>



# noddocker 
Simple tutorial for setting up ```NodeJS``` environment for development with <a href="https://docs.docker.com/" target="_blank">Docker</a>


## Getting started

This tutorial assumes that you have ```docker-ce``` and ```docker-compose``` installed on your local machine.

If you have both ```docker-ce``` and ```docker-compose``` installed, you can verify it by running this command in your terminal

``` docker --version && docker-compose --version ```

and you will have the output similar to this.

```
Docker version 17.03.1-ce, build c6d412e
docker-compose version 1.13.0, build 1719ceb
```
Please go to the official <a href="https://docs.docker.com/" target="_blank">Docker</a> website and install them if you don't.

## Initializing package.json.

```javascript

mkdir noddocker
cd nodddokcer
npm init
npm install express nodemon --save
```

```vim package.json ``` and add the following to package.json scripts section

```json
"scripts": {
    "start": "nodemon server.js"
  }
```

## Writing server.js

Lets write a basic nodejs app with express with a 'Hello World' route.

```
touch server.js
vim server.js
```
#### server.js
Add this enterprise level code.

```js
'use strict';

let express = require('express');
let app = express();


app.get('/', function(req, res){
  res.send("Hello World");
});


app.listen(3000, function(){
  console.log('Example app listening on port 3000!');
});

```

Being done with the basic application, let's move towards the fun part.

# Dockerizing our app.

### Define a container with a ```Dockerfile```


```Dockerfile``` will define what goes on in the environment inside your container

lets create one.

``` touch Dockerfile ```


```
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
```

## Building and Running the Docker Image


``` docker build -t noddocker:1 . ``` 
Note:- the . at the indicates the current directory where Dockerfile is located

the -t flag will tag this image as noddocker and run the steps provided in the ``` Dockerfile ``` we created above. 

### Note: ubuntu 14.04 
If your container fails to establish a network connection (can be tested with ``` ping ``` or ``` curl ```), then you have to remove your dns mask. 

```
sudo vim /etc/NetworkManager/NetworkManager.conf
```

Comment out the “dns=dnsmasq” line by putting a hash “#” in front it.

``` sudo service network-manager restart 
sudo service docker restart
```

#### Running image in container

``` docker run -ti -p 3000:3000 noddokcer:1 ```

Here, -p flag maps your local machines ```3000``` port to ```docker0```'s port exposed in the ```Dockerfile```.


# Finally

Your awesome enterprise level NodeApp is up and running! 

``` curl -i http://localhost:3000/ ``` returns ``` Hello world ``` 
