#!/bin/bash
set -ex

docker build -f Dockerfile.elixir -t grapevinehaus/elixir:1.10 .
