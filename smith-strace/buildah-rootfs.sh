#!/bin/bash

set -ex -o pipefail

fromCont=$(buildah from $1)
toCont=$(buildah from scratch)
buildah unshare bash unshared.sh $fromCont $toCont
buildah config \
  --entrypoint $(printf %s $(buildah inspect $fromCont | jq -cr .OCIv1.config.Entrypoint)) \
  --user       $(printf %q $(buildah inspect $fromCont | jq -cr .OCIv1.config.User))\
  --workingdir $(printf %q $(buildah inspect $fromCont | jq -cr .OCIv1.config.WorkingDir)) \
  $toCont

buildah inspect $toCont | jq .OCIv1.config
buildah commit $toCont dns-small
buildah rm $fromCont $toCont
