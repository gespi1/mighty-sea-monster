# setup
## host os
20.04.1-Ubuntu x86_64

## docker image build
docker version 20.10.3

build and run on your local
```
docker build . -t litecoin:<TAG>
docker run -it -v /var/run/docker.sock:/var/run/docker.sock --privileged --rm litecoin:<TAG>
```

## kubernetes
kubernetes version 1.20.2<br />
minikube version 1.18.1

Using minikube for a quick kubes cluster.
Don't want to use a registry and instead will have minikube/kubes pull from my local computer.
```
minikube start
minikube docker-env
eval $(minikube -p minikube docker-env)
docker build . -t litecoin:<TAG>
```

## helm
helm version 3.5.3

creating chart
```
cd 1-3
helm create litecoin-chart
```
deleted unnecessary files created by chart template and added the stateful-set redy to be templated. Build the chart with the following:
```
helm install litecoin litecoin-chart/ --values ./values.yaml
```
# explanations
## Q1 
I went with a [litecoin image made by uphold](https://hub.docker.com/r/uphold/litecoin-core)
This one was a little tricky as the uphold/litecoin-core:0.18.1 [Dockerfile](https://github.com/uphold/docker-litecoin-core/blob/0.18.1/0.18/Dockerfile) already checksummed the litecoind binary, feeling that it would be repetitive to do so in my Dockerfile, I decided to compare the SHAs for the image instead. My thinking, "if we have an authentic image then we have an authentic litecoind".
### P.S. 
after finishing the task i realized i over engineered this and i just needed to rebuild a litecoin image.

## Q2
very familiar with kubernetes. Applying the stateful-set manually.
```
k apply -f path/to/stateful-set.yaml
``` 
Referenced the [Kubernetes docs](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/) on Stateful sets in order to help me complete the manifest.

## Q3 
created a simple helm chart to use for deploying the statefulset to kubernetes. During the jenkins job it will build the image, sed the new tag on the overrides values.yaml, build the chart and deploy to kubernetes.


Jenkinsfile is based on Jenkins running on kubernetes and having the kubernetes plugin. Also creating a manifest file to define a pod for the jenkins job.

didnt test the Jenkinsfile since im running out of time, so i went based off of personal experiences with jenkins on kubernetes.

<b>Gitlab CI:</b> have used Gitlab CI plenty of times, last time i used it was 2017-2019. However i stood with my most recent CI tool, Jenkins.


<b>Travis CI:</b> have not been exposed to this tool.