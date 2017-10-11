FROM tomcat:7.0

MAINTAINER John Beieler <johnb30@gmail.com>

COPY . /src

RUN sed -i "s/httpredir.debian.org/`curl -s -D - http://httpredir.debian.org/demo/debian/ | awk '/^Link:/ { print $2 }' | sed -e 's@<http://\(.*\)/debian/>;@\1@g'`/" /etc/apt/sources.list

RUN apt-get clean && \
    apt-get update && \
    apt-get install -y \
      git \
      maven \
      openjdk-7-jdk \
      openjdk-7-jre-lib 
    
ENV CLIFF_VERSION 2.3.0

RUN curl -o /usr/local/tomcat/cliff.war "https://github.com/mitmedialab/CLIFF/releases/download/v$CLIFF_VERSION/cliff-$CLIFF_VERSION.war"

EXPOSE 8080

CMD sh /src/launch.sh
