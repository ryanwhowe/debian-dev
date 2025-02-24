###############################################################################
#     ___            ______            __
#    /   |  _  _____/_  __/___  ____  / /____
#   / /| | | |/_/ _ \/ / / __ \/ __ \/ / ___/
#  / ___ |_>  </  __/ / / /_/ / /_/ / (__  )
# /_/  |_/_/|_|\___/_/  \____/\____/_/____/
#
#

build:
	echo "##### Build the local image #####"
	docker build -t ryanwhowe/debian-dev:latest .

run:
	echo "##### Staring Container #####"
	docker run -it --name prompt --user=${CURRENT_UID} --rm --mount type=bind,src=./code,dst=/var/www/html ryanwhowe/debian-dev:latest zsh 

command:
	echo "##### Staring Container #####"
	docker run -it --name prompt --user=${CURRENT_UID} --rm --mount type=bind,src=./code,dst=/var/www/html ryanwhowe/debian-dev:latest /var/www/html/src/bin/console 

command:
	echo "##### Staring Container #####"
	docker run -it --name prompt --user=${CURRENT_UID} --rm --mount type=bind,src=./code,dst=/var/www/html ryanwhowe/debian-dev:latest /var/www/html/src/bin/console 