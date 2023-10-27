#!/bin/bash -e

# Move to the script directory
scriptDir=$(cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P)
pushd "${scriptDir}" > /dev/null

VirtEnv/bin/python -m pip freeze > requirements.txt

# Restore the original directory
popd > /dev/null
