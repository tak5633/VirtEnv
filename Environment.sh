#!/bin/bash -e

forceEnv="${1:-NoForce}"

if [[ -z "${PYTHON_ENV_1698421895}" ]] || [[ ${forceEnv} == "Force" ]] ;
then

export PYTHON_ENV_1698421895=1

#---------------------------------------------------------------------------------------------------
#
#---------------------------------------------------------------------------------------------------
function DoesPipConfigExist ()
{
   if ! test -f "${PIP_CONFIG_FILE}"; then
      echo "Error: pip.conf does not exist."
      echo "Info: Create a symbolic link to the target pip.conf."
      return 1
   fi

   return 0
}

export -f DoesPipConfigExist

#---------------------------------------------------------------------------------------------------
#
#---------------------------------------------------------------------------------------------------
function DoesRequirementsTxtExist ()
{
   if ! test -f "requirements.txt"; then
      echo "Error: requirements.txt does not exist."
      echo "Info: Create a symbolic link to the target requirements.txt."
      return 1
   fi

   return 0
}

export -f DoesRequirementsTxtExist

#---------------------------------------------------------------------------------------------------
#
#---------------------------------------------------------------------------------------------------
function PipDownload ()
{
   packages="${1}"

   # VirtEnv/bin/python -m pip download --cert=${APS_ZSCALER_CERT} --dest ${PYTHON_PACKAGES_DIR} ${packages} || return 1
   VirtEnv/bin/python -m pip download --dest "${PYTHON_PACKAGES_DIR}" ${packages} || return 1
}

export -f PipDownload

#---------------------------------------------------------------------------------------------------
#
#---------------------------------------------------------------------------------------------------
function PipInstall ()
{
   packages="${1}"

   if (( ONLINE_INSTALL == 1 )) ; then
      PipDownload "${packages}" || return 1
   fi

   VirtEnv/bin/python -m pip install --no-index --find-links "${PYTHON_PACKAGES_DIR}" ${packages} || return 1
}

export -f PipInstall

#---------------------------------------------------------------------------------------------------
#
#---------------------------------------------------------------------------------------------------

# Move to the script directory
scriptDir_1678483151=$(cd "$(dirname "${BASH_SOURCE[0]:-${(%):-%x}}")" ; pwd -P)
pushd "${scriptDir_1678483151}" > /dev/null

# Configure the environment
export ONLINE_INSTALL=1
export PIP_CONFIG_FILE=${scriptDir_1678483151}/pip.conf

export PYTHON_PACKAGES_DIR=${scriptDir_1678483151}/Packages
mkdir -p "${PYTHON_PACKAGES_DIR}"

# Restore the original directory
popd > /dev/null

fi
