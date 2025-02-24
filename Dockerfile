FROM php:8.4-fpm-bookworm

ARG UNAME=docker
ARG UID=1000
ARG GID=1000

RUN groupadd -g $GID -o $UNAME
RUN useradd -m -u $UID -g $GID -o -s /bin/zsh $UNAME

RUN apt update && apt upgrade -y

RUN apt install -y zsh zip unzip figlet fortune-mod curl wget bat exa git

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('sha384', 'composer-setup.php') === 'dac665fdc30fdd8ec78b38b9800061b4150413ff2e3b6f88543c636f7cd84f6db9189d43a81e5503cda447da73c7e5b6') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php --filename=composer --install-dir=/usr/local/bin
RUN php -r "unlink('composer-setup.php');"

COPY fortunes/ /usr/share/games/fortunes/

USER ${UNAME}
RUN sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

COPY oh-my-zsh/aliasez.zsh /home/docker/.oh-my-zsh/custom/
COPY oh-my-zsh/zshrc /home/docker/.zshrc
COPY oh-my-zsh/p10k.zsh /home/docker/.p10k.zsh