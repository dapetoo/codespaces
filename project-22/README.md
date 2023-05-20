# Deploying Applications into Kubernetes Cluster

## Requirements
 Kubernetes Cluster (Docker Desktop, Minikube, EKS, GKE, AKS, etc.)

 kubectl (Kubernetes CLI)

EKSCTL https://github.com/weaveworks/eksctl

Minikube https://minikube.sigs.k8s.io/docs/start/



DAREY.IO Documentations
https://www.darey.io/docs/deploying-applications-into-kubernetes-cluster/
1. https://www.darey.io/docs/common-kubernetes-objects/
2. https://www.darey.io/docs/accessing-the-app-from-the-browser/
3. https://www.darey.io/docs/understanding-the-concept/

References:
https://kubernetes.io/docs/concepts/overview/working-with-objects/#:~:text=A%20Kubernetes%20object%20is%20a,is%20your%20cluster's%20desired%20state.
https://phoenixnap.com/kb/kubernetes-objects

Common Kubernetes Objects
    Pods
    ReplicaSets
    Deployments
    Services
    Ingress
    ConfigMaps
    Secrets
    Volumes

Kubernetes Object Specifications
    apiVersion: 
    kind
    metadata
    spec

## Deploying a Pod

```bash
kubectl explain pod.apiVersion
kubectl explain pod.spec
kubectl explain pod.spec.containers
kubectl explain pod.spec.containers.ports
kubectl explain pod.spec.volumes


    kubectl run --generator=run-pod/v1 nginx --image=nginx
    kubectl apply -f <manifest.yml>
    kubectl delete -f <manifest.yml>

    kubectl get pods
    kubectl describe pod myapp-pod
    kubectl delete -f pod-definition.yml
```

kubectl get pod nginx-pod  -o wide  | Get IP address of the nginx pod and use it with the next step 


kubectl run curl --image=dareyregistry/curl -i --tty 

    curl 10.1.1.24

- Create service with the nginx-service.yaml file

Port forward 
kubectl  port-forward svc/nginx-service 8089:80 

kubectl get pods --show-labels //Get pod labels

kubectl get service nginx-service -o wide 

