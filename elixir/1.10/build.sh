#!/bin/bash
set -ex

DOCKER_BUILDKIT=1 docker build -t grapevinehaus/elixir:1.10.0-1 .
