source <(kubectl completion zsh)

kubectl_set() {
    if [[ $# -gt 0 ]]; then
        if [[ $1 == 'clear' ]]; then
            unset KUBECTL_CONTEXT
            unset KUBECTL_NAMESPACE
        elif [[ $1 == '.' ]]; then
            KUBECTL_CONTEXT=${KUBECTL_CONTEXT:-$(kubectl config current-context)}
        else
            KUBECTL_CONTEXT=$1
        fi

        if [[ -n $2 ]]; then
            KUBECTL_NAMESPACE=$2
        fi
    fi
}
