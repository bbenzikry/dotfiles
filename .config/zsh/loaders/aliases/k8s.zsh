# Get pod open ports
function kpodports(){
kubectl get pod $1 -n $2 --template='{{(index (index .spec.containers 0).ports 0).containerPort}}{{"\n"}}'
}

function fluxdesc(){
    kubectl describe helmreleases.helm.toolkit.fluxcd.io $@
}
