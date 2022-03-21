# tico-e-teco
Tico e Teco: an web server and a code server

## Launch

- `lxc launch ubuntu:20.04 tico-e-teco`

## Installation and configuration

Code-server:

- `CONTA=estudante`
- `apt update && apt install -y curl zsh zsh-autosuggestions`
- `curl -o /etc/skel/.zshrc https://raw.githubusercontent.com/ifrnlab/zsh-lab/main/zshrc.zsh`
- `useradd -m -c $CONTA -s /bin/zsh $CONTA`
- `curl -fsSL https://code-server.dev/install.sh | sh`
- `sudo systemctl enable --now code-server@$CONTA`
