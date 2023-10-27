$ErrorActionPreference = "Stop"

# Move to the script directory
pushd $PSScriptRoot

# Parse the arguments
$packages = $args

# Configure the environment
. ./Environment.ps1
if ($LASTEXITCODE -ne 0)
{
   exit 1
}

& VirtEnv/Scripts/python.exe -c "import ScriptFunctions; ScriptFunctions.DoesPipCertFileExist(r'$env:PIP_CONFIG_FILE')"
if ($LASTEXITCODE -ne 0)
{
   "Error: Pip cert file does not exist. Check $env:PIP_CONFIG_FILE"
   exit 1
}

# Download and install all packages
& VirtEnv/Scripts/python.exe -m pip download --find-links $packageDir --dest $packageDir $packages
& VirtEnv/Scripts/python.exe -m pip install --no-index --find-links $packageDir $packages

# Restore the original directory
popd
