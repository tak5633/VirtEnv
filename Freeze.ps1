$ErrorActionPreference = "Stop"

# Move to the script directory
pushd $PSScriptRoot

VirtEnv/Scripts/python.exe -m pip freeze > requirements.txt

# Restore the original directory
popd
