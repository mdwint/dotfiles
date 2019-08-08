# dotfiles

## Installation

```
curl https://raw.githubusercontent.com/mdwint/dotfiles/master/install.sh -sSf | sh
```

## Managing secrets

Backup secrets from your home directory to an encrypted archive:

```
~/dotfiles/secrets.sh backup secrets.tar.gz.encrypted .aws/ .ssh/
```

Restore archived secrets on a new machine:

```
~/dotfiles/secrets.sh restore secrets.tar.gz.encrypted
```
