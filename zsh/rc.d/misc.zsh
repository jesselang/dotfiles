# generate alphanumeric random string, optional parameter specifying length
function rand-an()
{
    dd if=/dev/urandom count=1 2>/dev/null | LC_CTYPE=C tr -dc 'a-zA-Z0-9' | cut -c1-${1:-}
}

function rand-b64()
{
    dd if=/dev/urandom count=1 2>/dev/null | LC_CTYPE=C tr -dc 'a-zA-Z0-9' | cut -c1-${1:-}
}
