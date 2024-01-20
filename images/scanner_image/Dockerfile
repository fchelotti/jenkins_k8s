FROM jenkins/jnlp-slave:alpine
USER root
RUN apk --no-cache add xorriso redis jq unzip
RUN wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.8.0.2856-linux.zip
RUN unzip sonar-scanner-cli-4.8.0.2856-linux.zip
RUN mv sonar-scanner-4.8.0.2856-linux /usr/local/sonar-scanner-4.8
RUN ln -s /usr/local/sonar-scanner-4.8/bin/sonar-scanner /usr/local/bin/sonar-scanner