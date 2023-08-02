# Bootstrap Kubernetes Cluster with Kops

Links

https://kops.sigs.k8s.io/getting_started/install/
https://kops.sigs.k8s.io/getting_started/aws/

```bash
# Kops cluster state bucket
aws s3api create-bucket \
    --bucket p25-kops-cluster \
    --region us-east-1

# Enable versioning
aws s3api put-bucket-versioning --bucket p25-kops-cluster  --versioning-configuration Status=Enabled


export NAME=cluster.peterdada.me
export KOPS_STATE_STORE=s3://cluster.peterdada.me

kops create cluster --name=${NAME} --cloud=aws --zones=us-east-1a --state=s3://cluster.peterdada.me

#Edit Cluster
kops edit cluster --name ${NAME}

#Build the cluster
kops update cluster --name ${NAME} --yes --admin

#Validate the cluster
kops validate cluster --wait 10m


kubectl -n kube-system get po

#Delete the cluster
kops delete cluster --name ${NAME} --yes

```

## Artifactory installation using Helm Chart

```bash
helm install my-artifactory jfrog/artifactory --version 107.33.12

helm uninstall my-artifactory && sleep 90 && kubectl delete pvc -l app=artifactory

helm install cert-manager jetstack/cert-manager --namespace cert-manager --create-namespace --version v1.12.0 