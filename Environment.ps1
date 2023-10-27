param
(
   [bool] $forceEnv = $false
)

if (!$PYTHON_ENV_1618880954 -or $forceEnv)
{

[bool] $PYTHON_ENV_1618880954 = $true

# Move to the script directory
pushd $PSScriptRoot

[bool] $onlineInstall = $true
[string] $env:PIP_CONFIG_FILE = "${PSScriptRoot}/pip.conf"

[bool] $doesPipConfExist = Test-Path -Path $env:PIP_CONFIG_FILE -PathType Leaf
if (!$doesPipConfExist)
{
   "Error: pip.conf does not exist."
   "Info: Create a hard link to the target pip.conf."
   exit 1
}

[bool] $doesRequirementsTxtExist = Test-Path -Path "${PSScriptRoot}/requirements.txt" -PathType Leaf
if (!$doesRequirementsTxtExist)
{
   "Error: requirements.txt does not exist."
   "Info: Create a hard link to the target requirements.txt."
   exit 1
}

$packageDir = "${PSScriptRoot}/Packages"
md -Force $packageDir | Out-Null

# Restore the original directory
popd

}

exit 0
