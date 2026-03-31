# debian-dev
Custom build Debian image definition for development work

## Build local test
Build and run a local test version of the image

```bash
docker build -t ryanwhowe/debian-dev:test .

```

Run the newly created image with the current directory mounted to the mount folder inside the container
```bash
docker run --rm -it -v "$(pwd)":/root/mounted ryanwhowe/debian-dev:test zsh
```
