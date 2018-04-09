#!/bin/sh

main() {
  if [ -n "${TRAVIS}" ]; then
    docker login -u "${DOCKER_USER}" -p "${DOCKER_PASSWD}"
  else
    docker login
  fi

  if [ -n "$1" ]; then
    TAG="$1" push
  else
    TAGS="$(find . -name Dockerfile -exec dirname {} \;)"

    for TAG in ${TAGS}; do
      TAG="$(echo ${TAG} | sed -e "s/\\.\\///")"

      push "${TAG}"
    done
  fi
}

push() {
  TAG=${1:-${TAG}}

  echo
  echo "Uploading ${TAG}.."
  echo
  docker push "ntrrg/bind:${TAG}"
  echo
  echo "Done (${TAG})"
}

main $@
