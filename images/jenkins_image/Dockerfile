FROM jenkins/jenkins:2.401.2-lts-jdk11
USER root
RUN apt-get update && apt-get clean && apt-get autoremove
RUN mkdir /srv/backup && chown jenkins:jenkins /srv/backup
USER jenkins
RUN echo 2.401.2 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state
RUN echo 2.401.2 > /usr/share/jenkins/ref/jenkins.install.InstallUtil.lastExecVersion
COPY --chown=jenkins:jenkins config_jenkins /var/jenkins_home
COPY plugins_new.txt /usr/share/jenkins/ref/plugins_new.txt
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins_new.txt