# docker-builds-haconiwa

The Docker base image that builds Haconiwa

## Build deb

```bash
$ docker build -t udzura/builds-haconiwa-deb:0.0.1 deb/
$ docker run \
    -v`pwd`/pkg:/out/pkg \
    -v/path/to/local/haconiwa:/build/haconiwa \ # If you want to specify source
    -v`pwd`/example_build_config.rb:/build/build_config.rb \ # If want to customize build_config
    --rm -t udzura/builds-haconiwa-deb:0.0.1
## And then if you specify/override version, instead run:
## This requires `/build/haconiwa' mounted
#   --rm -t udzura/builds-haconiwa-deb:0.0.1 0.8.5test1
```
