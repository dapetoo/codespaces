# Project 23

References
----------
https://kubernetes.io/docs/setup/production-environment/tools/kops/ -Kubernetes

https://brew.sh/ -Homebrew

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

```bash
# Install kops
brew update && brew install kops

#Linux install
curl -Lo kops https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64
chmod +x kops
sudo mv kops /usr/local/bin/kops


# AWS IAM USERS
aws iam create-group --group-name kops

aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonEC2FullAccess --group-name kops
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonRoute53FullAccess --group-name kops
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess --group-name kops
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/IAMFullAccess --group-name kops
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonVPCFullAccess --group-name kops
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonSQSFullAccess --group-name kops
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonEventBridgeFullAccess --group-name kops

aws iam create-user --user-name kops

aws iam add-user-to-group --user-name kops --group-name kops

aws iam create-access-key --user-name kops

aws s3api create-bucket \
    --bucket prefix-example-com-state-store \
    --region us-east-1

aws s3api create-bucket \
    --bucket dapetoo-prefix-example-com-oidc-store \
    --region us-east-1 \
    --acl public-read


aws s3api put-bucket-versioning --bucket kop-prefix-example-com-state-store  --versioning-configuration Status=Enabled

aws s3api put-bucket-encryption --bucket kop-prefix-example-com-state-store --server-side-encryption-configuration '{"Rules":[{"ApplyServerSideEncryptionByDefault":{"SSEAlgorithm":"AES256"}}]}'

export NAME=myfirstcluster.k8s.local
export KOPS_STATE_STORE=s3://kop-prefix-example-com-state-store

kops create cluster --zones=us-east-1c --cloud=aws --name=${NAME}

kops create cluster \
    --name=${NAME} \
    --cloud=aws \
    --zones=us-east-1a \
    
    # --discovery-store=s3://kop-prefix-example-com-oidc-store/${NAME}/discovery

kops update cluster --name ${NAME} --yes --admin


kops update cluster --name myfirstcluster.k8s.local --yes --admin



