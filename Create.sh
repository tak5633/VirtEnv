#!/bin/bash -e

# Move to the script directory
scriptDir=$(cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P)
pushd "${scriptDir}" > /dev/null

# Create the virtual environment
python3 -m venv VirtEnv
VirtEnv/bin/python -m pip install wheel

# Restore the original directory
popd > /dev/null
