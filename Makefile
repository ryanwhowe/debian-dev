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
	docker build -t ryanwhowe/debian-dev:test .

run:
	echo "##### Running local test image #####"
	docker run --rm -e TZ="America/New_York" -it -v "$$(pwd)":/root/mounted ryanwhowe/debian-dev:test