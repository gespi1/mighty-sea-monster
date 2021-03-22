#!/bin/bash
kubectl get secrets --all-namespaces  | grep kubernetes.io/service-account-token | while read line; do ns=`echo $line | tr -s ' ' | cut -d ' ' -f 1`; secretname=`echo $line | tr -s ' ' | cut -d ' ' -f 3`; kubectl delete secret -n $ns $secretname; done
