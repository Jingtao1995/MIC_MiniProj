# Node 14 on an Alpine
FROM node:fermium

# on top of node we need Python
RUN apt-get update && \
    apt-get install -y git\
        apt-transport-https \
        python \
        python-pip \
        python3-pip \
        python-setuptools
# we also need the latest webgme-bindings to be able to run python plugins
RUN pip install webgme_bindings
RUN pip3 install webgme-bindings

# just creating the directories where our webgme server will run
RUN mkdir /usr/app
WORKDIR /usr/app

# copy app source
ADD config /usr/app/config/
ADD src /usr/app/src/
ADD package.json /usr/app/
ADD webgme-setup.json /usr/app/
ADD app.js /usr/app/

# Install node-modules
RUN npm install
 
CMD ["npm", "start"]


