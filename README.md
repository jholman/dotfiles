

Most of the files in this repo are `.rc` files, intended to be symlinked (or hardlinked or copied over, *I guess*).  This file, ofc, is not such.  Also I've had other text files in this repo in the past.


This file contains my notes to myself for getting a new linux shell up to some degree of usability as fast as possible.  It doesn't include plans to get a Linux desktop environment usable, which I haven't done for a long time.  Though if you're reading this and you want my opinion, my opinion is XFCE or LXDE.




## Apt packages

As a first step, let's install some packages from apt

```
sudo apt-get install                      \
  tree git bash-completion man-db         \
  python3 python3-pip python-is-python3   \
  vim vim-doc                             \
  gcc g++ build-essential                 \
  yt-dlp youtubedl-gui                    \
  openssh-client jq unzip                 \
  imagemagick netpbm libtiff-tools entr   \
  postgresql postgresql-doc               \
  audacious

### obsolete
# sudo apt-get install python2.7 python-pip 
```


## Bootstrapping the dotfiles repo

Then, set up the .ssh directory manually:

* `mkdir ~/.ssh`
* set up a keypair for main SSH-to-Github identity
    * the last time I was doing this I copied a keypair from my previous system
    * but usually I would `ssh-keygen -t ed25519 -C "comment here"`
        * for a comment I use `${my username} / ${which service (eg github)} / ${name of machine}`
        * and then I'd need to upload to github
* manually copy the sshconfig into ~/.ssh/config

The purpose of the above is to allow git cloning, including git cloning this very repo.

I assume it has been cloned to `~/wrks/dotfiles`


## Binding dotfiles.

THEN we can link up all the relevant dotfiles.

```bash

mkdir ~/nonconfigs

mv ~/.ssh/config ~/nonconfigs/sshconfig
ln -s ~/wrks/dotfiles/sshconfig ~/.ssh/config

mv ~/.bashrc ~/nonconfigs/
ln -s ~/wrks/dotfiles/bashrc ~/.bashrc

mv ~/.bash_profile ~/nonconfigs/
ln -s ~/wrks/dotfiles/bash_profile ~/.bash_profile

mv ~/.gitconfig ~/nonconfigs/
ln -s ~/wrks/dotfiles/gitconfig ~/.gitconfig

mv ~/.vimrc ~/nonconfigs/
ln -s ~/wrks/dotfiles/vimrc ~/.vimrc

mv ~/.npmrc ~/nonconfigs/
ln -s ~/wrks/dotfiles/npmrc ~/.npmrc

mv ~/.yarnrc ~/nonconfigs/
ln -s ~/wrks/dotfiles/yarnrc ~/.yarnrc

mv ~/.psqlrc ~/nonconfigs/
ln -s ~/wrks/dotfiles/psqlrc ~/.psqlrc

```




## Setting up JS tools

First install nvm
```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
```

Then install a recent nodejs
```bash
nvm install --lts --latest-npm
```

I'd like to install yarn as well.  I previously used an install script (`curl -o- -L https://yarnpkg.com/install.sh | bash`), and there are complicated options for apt-installing (note that the Ubuntu package for `yarn` is *not* the right thing).

```bash
npm install --global yarn
```

Also I'd like yarn to have bash-completion, which I'm getting from https://github.com/dsifford/yarn-completion

```bash
mkdir -p "${BASH_COMPLETION_USER_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/bash-completion}/completions/"
curl -o "${BASH_COMPLETION_USER_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/bash-completion}/completions/yarn" \
	https://raw.githubusercontent.com/dsifford/yarn-completion/master/yarn-completion.bash
```


### obsolete

I used to want to tweak yarn a bit, but I think it's taken care of in the `.yarnrc` above?

>  yarn config set init-version '0.1.0'
>  yarn config set init-private true
>  yarn config set init-license "UNLICENSED"

Are there other packages I should want to install globally?
> npm install -g nodemon



## Postgres Setup hints

Wanna use postgres?  After installing, remember to
  * create a role in the DB for myself, probably like this:
    * `sudo su postgres -c 'createuser jholman --superuser' `
  * optionally create a self-named DB to make `psql` easier
    * `createdb jholman`
  * fiddle with pg_hba.conf as necessary
    * maybe add "local all all trust" if you wanna let all users log in as anyone (via unix sockets)
    * but then again, it already has "local all all peer", which is enough for jholman to log in as jholman

