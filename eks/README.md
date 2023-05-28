# EKS Cluster with Terraform

## Resources Links
- AWS VPC module: https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest
- AWS EKS module: https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest

```bash
#Create S3 bucket
aws s3 mb s3://eks-bucket-backend-terraform

terraform -out eks.tfplan

terraform apply -auto-approve eks.tfplan

#Generate Kubeconfig file with the latest cluster information
aws eks update-kubecofig --name <cluster_name> --region <cluster_region> --kubeconfig kubeconfig

#Update kubeconfig file with cluster information
 aws eks update-kubeconfig --name tooling-app-eks --region us-east-1 

#Install HELM
#Window
choco install kubernetes-helm

#Linux & Mac
brew install helm

#Linux
sudo snap install helm --classic

#Using the binary
https://github.com/helm/helm/releases

#Helm Chart (Artifcact Hub)
https://artifacthub.io/packages/

#Deploy Jenkins with Helm
helm repo add jenkins https://charts.jenkins.io
helm repo update
helm install my-jenkins jenkins/jenkins --version 4.3.23 

#Get Jenkins admin password
kubectl exec --namespace default -it svc/my-jenkins -c my-jenkins -- /bin/cat /run/secrets/chart-admin-password && echo

Get the Jenkins URL to visit by running these commands in the same shell:
  echo http://127.0.0.1:8080
  kubectl --namespace default port-forward svc/my-jenkins 8080:8080


#Install Krew
https://krew.sigs.k8s.io/docs/user-guide/setup/install/

#Install Krew plugin
kubectl krew install konfig

#Deploy Promethus with Helm
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm install my-prometheus prometheus-community/prometheus --version 22.6.2

#Prometheus Server
export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/component=server" -o jsonpath="{.items[0].metadata.name}")
kubectl --namespace default port-forward $POD_NAME 9090

#AlertManager
export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/instance=my-prometheus,app.kubernetes.io/name=alertmanager" -o jsonpath="{.items[0].metadata.name}")
  kubectl --namespace default port-forward $POD_NAME 9093

#PushGateway
export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/instance=my-prometheus,app.kubernetes.io/managed-by=Helm" -o jsonpath="{.items[0].metadata.name}")
  kubectl --namespace default port-forward $POD_NAME 9091


#Deploy Grafana
helm repo add grafana https://grafana.github.io/helm-charts

kubectl get secret --namespace default my-grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo

export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/name=grafana,app.kubernetes.io/instance=my-grafana" -o jsonpath="{.items[0].metadata.name}")

 kubectl --namespace default port-forward $POD_NAME 3000


#Elasticsearch
helm repo add elastic https://helm.elastic.co
helm install my-elasticsearch elastic/elasticsearch --version 8.5.1

#Hasicorp Vault
helm repo add hashicorp https://helm.releases.hashicorp.com

kubectl exec --stdin=true --tty=true <vault-0> -- vault operator init

## Unseal the first vault server until it reaches the key threshold
$ kubectl exec --stdin=true --tty=true my-vault-0 -- vault operator unseal # ... Unseal Key 1
$ kubectl exec --stdin=true --tty=true my-vault-0 -- vault operator unseal # ... Unseal Key 2
$ kubectl exec --stdin=true --tty=true my-vault-0 -- vault operator unseal # ... Unseal Key 3
















