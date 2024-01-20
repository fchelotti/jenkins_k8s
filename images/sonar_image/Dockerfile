FROM sonarqube:lts-community
USER root
RUN apt-get update -y && apt-get clean -y && apt-get autoremove -y
USER sonarqube
RUN wget --no-check-certificate https://github.com/felipebz/zpa/releases/download/3.2.1/sonar-zpa-plugin-3.2.1.jar -O /opt/sonarqube/extensions/plugins/sonar-zpa-plugin-3.2.1.jar
COPY plugins/*.jar /opt/sonarqube/extensions/plugins/
