$ErrorActionPreference = "Stop"

# Move to the script directory
pushd $PSScriptRoot

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

# Download all packages
if ($onlineInstall)
{
   & VirtEnv/Scripts/python.exe -m pip download --find-links $packageDir --dest $packageDir -r requirements.txt
}

# Install all packages
& VirtEnv/Scripts/python.exe -m pip install --no-index --find-links $packageDir -r requirements.txt

# Restore the original directory
popd
