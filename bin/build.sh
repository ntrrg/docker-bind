#!/bin/sh

main() {
  if [ -n "$1" ]; then
    TAG="$1" build
  else
    TAGS="$(find . -name Dockerfile -exec dirname {} \;)"

    for TAG in ${TAGS}; do
      TAG="$(echo ${TAG} | sed -e "s/\\.\\///")"

      build "${TAG}" || return 1
    done
  fi
}

build() {
  TAG=${1:-${TAG}}

  echo
  echo "Building ${TAG}.."
  echo
  docker build -t "ntrrg/bind:${TAG}" "${TAG}" || return 1
  docker run --rm "ntrrg/bind:${TAG}" named-checkconf || return 1
  echo
  echo "Done (${TAG})"
}

main $@
