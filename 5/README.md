## Solving for 4-1 on Python
The following [main.py](./main.py) file is solving the issue presented in problem [4-1](../4/4-1.sh) but in python. The 4-1 issue is further described [here](../4/README.md).

## Whats it doing? 
Grabbing and iterating through all the secrets available in the kubernetes cluster and looking for Service Account secrets.
Once the script has detected a Service Account secret it will delete that secret.

## Python Version
3.8.5


[other py requirements](./requirements.txt)

## Kubernetes Version
1.20.2