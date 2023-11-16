# bash-aliases-installation
Script d'installation des aliases que j'ai développé

## Prérequis

```shell
export SUDO_PASSWD="mot de passe sudo"
```

## Installation

```shell
git clone git@github.com:nicolachoquet06250/bash-aliases-installation.git aliases
```
ou
```shell
git clone https://github.com/nicolachoquet06250/bash-aliases-installation.git aliases
```

## Installer un script
```shell
sudo chmod +x install.sh
./install.sh repo-name repo-name-2 ...
```

## Liste des aliases disponibles pour le moment

- [bash-aliases-framework](https://github.com/nicolachoquet06250/bash-aliases-framework)
  - Framework de création d'aliases bash.
- [bash-alias-clipboard](https://github.com/nicolachoquet06250/bash-alias-clipboard)
  - Alias permettant de simplifier le copier coller en mode texte.
- [bash-alias-alwaysdata](https://github.com/nicolachoquet06250/bash-alias-alwaysdata)
  - Alias pour faire une surcouche à l'API Rest de l'hébergeur Alwaysdata
- [bash-aliases-norsys](https://github.com/nicolachoquet06250/bash-aliases-norsys)
  - Alias regroupant les outils pour les developpeurs norsys
- [oh-my-posh-installer](https://github.com/nicolachoquet06250/oh-my-posh-installer)
  - Alias permettant de simplifier l'installation de "Oh My Posh"