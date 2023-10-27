#!/bin/bash -e

# Move to the script directory
scriptDir=$(cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P)
pushd "${scriptDir}" > /dev/null

# Configure the environment
source ./Environment.sh

DoesPipConfigExist
DoesRequirementsTxtExist

python3 -c "import ScriptFunctions; ScriptFunctions.DoesPipCertFileExist('${PIP_CONFIG_FILE}')" \
   || { echo "Error: Pip cert file does not exist. Check ${PIP_CONFIG_FILE}"; exit 1; }

PipInstall "-r requirements.txt"

#VirtEnv/bin/python -m pip install --no-deps --force-reinstall ${PYTHON_WHEELS_DIR}/protobuf-3.6.1-cp36-cp36m-manylinux1_x86_64.whl

# Add the third party sites
source VirtEnv/bin/activate
distPkgsDir=$(python -c 'import site; print(site.getsitepackages()[-1])')
mkdir -p "${distPkgsDir}"
deactivate

# Restore the original directory
popd > /dev/null
