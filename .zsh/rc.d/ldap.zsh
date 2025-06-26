ldap_search() {
    local command=(
        ldapsearch -b "${LDAP_BASE_SEARCH}"
            -H "${LDAP_SERVER_URI}"
            -D "${LDAP_DOMAIN}\\${LDAP_USER:-$USER}"
            ${LDAP_PASSWORD+"-w"}
            "${LDAP_PASSWORD:-"-W"}"
            "$@"
    )

    # print the command to stderr so folks can copy/pasta
    echo -n '# ' >&2
    for x in ${command[@]}; do
        if [[ -n ${LDAP_PASSWORD:-} ]] && [[ $x == $LDAP_PASSWORD ]]; then
            echo -n '"$LDAP_PASSWORD"' >&2
        elif [[ $x =~ ^[-a-zA-Z0-9_.,=+/:]+$ ]]; then
            echo -n $x >&2
        else
            # quote values that have something other than known safe characters
            echo -n "\"$x\"" >&2
        fi
        echo -n ' ' >&2
    done
    echo >&2

    ${command[@]}
}

ldap_user() {
    ldap_search "(|(sAMAccountName=$1)(userPrincipalName=$1))"
}
