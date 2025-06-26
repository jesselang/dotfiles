# functions that help me do common tasks with k8s

# create a temporary but valid tls secret
function kube-tls()
{
    [[ -z $1 ]] && {
        echo "error: specify tls secret name" >&2
        return 1
    }
    (
        set -e
        openssl req -x509 -newkey rsa:2048 -nodes -days 1 \
            -subj "/C=XX/ST=XX/L=Temporary/O=Temporary/CN=temporary" \
            -keyout /tmp/key.pem -out /tmp/cert.pem
        kubectl create secret tls "$1" --cert=/tmp/cert.pem --key=/tmp/key.pem
    ); local __rv=$?
    rm -f /tmp/cert.pem /tmp/key.pem
    return $__rv
}

function inspect-pvc()
{
    [[ -z $1 ]] && echo "error: specify pvc name" >&2
    cat - <<EOF | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: inspect-$1
spec:
  terminationGracePeriodSeconds: 0
  containers:
  - name: inspect
    image: ${2:-busybox}
    command:
      [ tail, -f, /dev/null ]
    volumeMounts:
      - name: pvc
        mountPath: /pvc
  volumes:
    - name: pvc
      persistentVolumeClaim:
        claimName: $1
EOF
}

