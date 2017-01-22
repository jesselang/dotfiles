export PYTHONDONTWRITEBYTECODE=1 # *.pyc files are ugly.

# OS flags
export OS_NAME=${$(uname -s):l}
export OS_${OS_NAME:u}=1
