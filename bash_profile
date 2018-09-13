
# TODO: disentangle the knot of startup scripts: ~/.profile ~/.bash_profile /etc/profile and so on
# TODO: maybe move some of this to .profile, and either way put .profile into git

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

[[ -s "$HOME/.cargo/bin" ]] && export PATH="$HOME/.cargo/bin:$PATH"
