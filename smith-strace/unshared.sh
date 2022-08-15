#!/bin/bash

set -ex -o pipefail

fromDir=$(buildah mount $1)
toDir=$(buildah mount $2)

rsync -alv $fromDir $toDir --files-from=$fromDir/home/app/app.spec
