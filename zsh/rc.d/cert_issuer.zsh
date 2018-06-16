# great for figuring out when a MitM TLS cert is involved
# I'm looking at you, zscaler. Thanks to @rkennedy for this.
cert_issuer() {
    local server=${1:?};
    openssl s_client -showcerts -servername $server -connect $server:443 </dev/null 2>/dev/null \
        | openssl x509 -inform pem -noout -issuer -nameopt multiline;
}
