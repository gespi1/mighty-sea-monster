# image taken from https://github.com/jenkins-x/jenkins-x-builders
# jenkinsx images make it easy to run your pod on jenkins as it has the prequisites to build docker in docker on jenkins
FROM gcr.io/jenkinsxio/builder-go:2.1.155-778

# installing helm using https://www.techrepublic.com/article/how-to-install-the-kubernetes-package-manager-helm/
RUN wget https://get.helm.sh/helm-v3.5.3-linux-amd64.tar.gz \
    && tar xvf helm-v3.0.2-linux-amd64.tar.gz \
    && mv linux-amd64/helm /usr/local/bin/

# entrypoint will be set in pod.yaml