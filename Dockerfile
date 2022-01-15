# Using CentOS 7 as base image to support rpmbuild (packages will be Dist el7)
FROM centos:7

# Copying all contents of rpmbuild repo inside container
COPY . .

# Installing tools needed for rpmbuild, other tools have to be added on BuildRequires field in specfile.
RUN yum install -y git rpmdevtools epel-release

# Setting up node to run our JS file
# Download Node Linux binary
RUN curl -O https://nodejs.org/dist/v17.3.1/node-v17.3.1-linux-x64.tar.xz

# Extract and install
RUN tar --strip-components 1 -xf node-v* -C /usr/local

# Install dependecies and build main.js
RUN npm install --production && npm run-script build

# All remaining logic goes inside main.js,
# where we have access to both tools of this container and
# contents of git repo at /github/workspace
ENTRYPOINT ["node", "/lib/main.js"]
