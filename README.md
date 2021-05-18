# README

https://confluence.quantium.com.au/display/~DShen/IIP+Cloud+project+on+boarding


## Install Istio in AKS

1. install

        istioctl install --set profile=default

2. create and label a namespace in Kubernetes

        kubectl create namespace demo
        kubectl label namespace demo istio-injection=enabled --overwrite

3. apply aks.yaml

        kubectl apply -f aks.yaml

4. get the ingress gateway external ip

        kubectl describe -n istio-system service/istio-ingressgateway
