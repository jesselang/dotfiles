[[ -z _kubectl ]] && source <(kubectl completion zsh)

kcn() {
    local _context_list=($(kubectl config view -o template \
        --template="{{range .contexts}}{{.name}} {{end}}"))
    if [[ ${#} -le 0 ]]; then
        if [[ -z ${KUBECTL_CONTEXT} ]]; then
            echo "contexts:"
            for c in ${_context_list}; do
                echo "  ${c}"
            done
        else
            local _namespace_list=($(kubectl get namespaces -o template \
                --template="{{range .items}}{{.metadata.name}} {{end}}"))
            echo "namespaces:"
            for n in ${_namespace_list}; do
                echo "  ${n}"
            done
        fi
    else
        local _prev_context=${KUBECTL_CONTEXT}
        local _prev_namespace=${KUBECTL_NAMESPACE}

        if [[ ${@[(r)--help]} ]]; then
            echo "usage: ${0} <context> [<namespace>]" >&2
            return 0
        elif [[ ${@[(r)--clear]} ]]; then
            unset KUBECTL_CONTEXT
            unset KUBECTL_NAMESPACE
        elif [[ ${1} == '.' ]]; then
            KUBECTL_CONTEXT=${KUBECTL_CONTEXT:-$(kubectl config current-context)}
            KUBECTL_NAMESPACE=${KUBECTL_NAMESPACE:-default}
        elif [[ ! ${_context_list[(r)${1}]} ]]; then
            echo "error: context ${1} not found" >&2
            return 1
        else
            KUBECTL_CONTEXT=${1}
            KUBECTL_NAMESPACE=${KUBECTL_NAMESPACE:-default}
        fi

        if [[ -n ${2} ]]; then
            local _namespace_list=($(kubectl get namespaces -o template \
                --template="{{range .items}}{{.metadata.name}} {{end}}"))
            if [[ ! ${_namespace_list[(r)$2]} ]]; then
                echo "error: namespace ${2} not found in context ${KUBECTL_CONTEXT}" >&2
                KUBECTL_CONTEXT=${_prev_context}
                KUBECTL_NAMESPACE=${_prev_namespace}
                return 2
            else
                KUBECTL_NAMESPACE=${2}
            fi
        fi
    fi
}
