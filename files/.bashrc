# ~/.bashrc: executed by bash for non-login shells.
# Por Ismael Damião
# Site: https://ismaeldamiao.github.io/
# E-mail: ismaellxd@gmail.com
# Última alteração: 16 de abril de 2024

if tty > /dev/null; then # Executar somente em terminal interativo
# ******************************************************************************
# Comando para Distros Linux e Termux
# ******************************************************************************

HISTCONTROL=ignoreboth # Para ignorar comandos duplicados
HISTSIZE=1000 # Quantidades de comandos que serão lembrados
HISTFILESIZE=2000
shopt -s histappend

# ******************
# aliases
# ******************
alias ls='ls --color=auto -h'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -s'
alias clear='clear && clear'
alias ps='ps arxu'
alias cp='cp -R' # ↓ aliases recursivos
alias rm='rm -R' # Cuidado, perigoso!!
alias mkdir='mkdir -p'
alias scp='scp -rp'
#alias myip='curl ipinfo.io/ip'

# ******************
# Paleta de cores
# ******************
BLACK="\e[30m"
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
WHITE="\e[37m"
BOLD="\e[1;37m"
LIGHT="\e[0;37m"
LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:';
export LS_COLORS

export PATH="$HOME/bin:$PATH"

which termux-setup-storage > /dev/null && {
   # ***************************************************************************
   # Comando específicos do Termux
   # ***************************************************************************
   USER='user'
   HOSTNAME='$(getprop ro.product.model)'
   PS1FINAL='\n\$ '
   # Facilitar acesso ao diretório do ubuntu
   UBUNTU=$HOME/ubuntu/ubuntu-fs/root
   # aliases Termux
   alias termux-open='termux-open --chooser'
} || {
   # ***************************************************************************
   # Comando específicos de Distros Linux
   # ***************************************************************************
   PS1FINAL='\$ '
   # aliases distros
   alias sshd='sudo su -c "/etc/init.d/ssh restart"'
}
# Mude aqui as cores ou outras coisas do PS1, se quiser
if [ "$EUID" -ne 0 ]; then # Quando usuario comum
export PS1="\[$BOLD$GREEN\]$USER\[$WHITE\]@\[$GREEN\]$HOSTNAME\[$WHITE\]:\[$BLUE\]\w\[$WHITE\]$PS1FINAL\[$LIGHT\]"
else # Quando usuario root
export PS1="\[$BOLD$RED\]$USER\[$WHITE\]@\[$RED\]$HOSTNAME\[$WHITE\]:\[$BLUE\]\w\[$WHITE\]$PS1FINAL\[$LIGHT\]"
fi
fi # tty
