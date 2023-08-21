## Deploy Jenkins

```bash
helm repo add jenkins https://charts.jenkins.io/
helm install my-jenkins jenkins/jenkins --version 4.5.0
``````

1. Get your 'admin' user password by running:
   ``````
  kubectl exec --namespace default -it svc/my-jenkins -c jenkins -- /bin/cat /run/secrets/additional/chart-admin-password && echo
  ``````
1. Get the Jenkins URL to visit by running these commands in the same shell:
  echo http://127.0.0.1:8080
  kubectl --namespace default port-forward svc/my-jenkins 8080:8080

1. Login with the password from step 1 and the username: admin
2. Configure security realm and authorization strategy
3. Use Jenkins Configuration as Code by specifying configScripts in your values.yaml file, see documentation: http://127.0.0.1:8080/configuration-as-code and examples: https://github.com/jenkinsci/configuration-as-code-plugin/tree/master/demos
```

## Deploy Artifactory
```bash
helm install my-artifactory jfrog/artifactory --version 107.63.12
``````
## Deploy Prometheus and Grafana
```bash
helm install my-prometheus prometheus-community/prometheus --version 23.3.0

helm install my-grafana grafana/grafana --version 6.58.9
``