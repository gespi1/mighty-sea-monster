from kubernetes import client, config
import platform
# used kubernetes-client library documentation as reference https://github.com/kubernetes-client/python/blob/master/kubernetes/README.md

###
# WARNING
# deletes every kubernetes.io/service-account-token secret within your current contexted cluster
# WARNING
##

def main():
  config.load_kube_config()                                         # by default loads  kube config from ~/.kube/config
  kubeclient = client.CoreV1Api()                                   # establish coreAPI client
  secrets = kubeclient.list_secret_for_all_namespaces(watch=False)  # return all secrets within the cluster
  for secret in secrets.items:                                      # iterate through secrets 
    if secret.type == "kubernetes.io/service-account-token":        # looking for secrets of type service-account-token
      kubeclient.delete_namespaced_secret(name=secret.metadata.name, namespace=secret.metadata.namespace) # if match, delete secret

if __name__ == "__main__":
  main()