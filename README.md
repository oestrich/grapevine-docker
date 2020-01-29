# Grapevine Docker Images

This repo follows along with the official [Erlang](https://hub.docker.com/_/erlang) and [Elixir](https://hub.docker.com/_/elixir) docker images, but exists to pin more concretely to versions. The official images also don't work on Ubuntu 18.04 LTS, as they use `buster` as the base now. This only matters if you generate a release inside of docker to use natively on a VPS.

## Build a new image

Use the build scripts to generate new base images. Make sure to update the tag inside if an Elixir version changes.

```bash
./build-elixir.sh
docker push grapevinehaus/elixir:1.10.0-1
```
