#!/bin/bash -e

# Move to the script directory
scriptDir=$(cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P)
pushd "${scriptDir}" > /dev/null

# Parse the arguments
packages="${*}"

# Configure the environment
source ./Environment.sh

DoesPipConfigExist
DoesRequirementsTxtExist

python3 -c "import ScriptFunctions; ScriptFunctions.DoesPipCertFileExist('${PIP_CONFIG_FILE}')" \
   || { echo "Error: Pip cert file does not exist. Check ${PIP_CONFIG_FILE}"; exit 1; }

# Install all packages
PipInstall "${packages}" || exit 1

# Restore the original directory
popd > /dev/null
