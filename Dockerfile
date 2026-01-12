FROM php:8.4-fpm-trixie

ENV TZ="America/New_York"

RUN apt update && \
apt upgrade -y && \
apt install -y zsh zip unzip figlet fortune-mod curl wget bat eza git vim ffmpeg gzip p7zip-full && \
apt autoremove -y && apt autoclean -y

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
php composer-setup.php --filename=composer --install-dir=/usr/local/bin && \
php -r "unlink('composer-setup.php');"

RUN wget https://get.symfony.com/cli/installer -O - | bash && \
    mv /root/.symfony5/bin/symfony /usr/local/bin/symfony

#USER ${UNAME}
RUN sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" && \
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

COPY fortunes/ /usr/share/games/fortunes/
COPY oh-my-zsh/aliasez.zsh /root/.oh-my-zsh/custom/
COPY oh-my-zsh/zshrc /root/.zshrc
COPY oh-my-zsh/p10k.zsh /root/.p10k.zsh

WORKDIR /root
