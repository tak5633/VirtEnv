$ErrorActionPreference = "Stop"

#---------------------------------------------------------------------------------------------------
# Copied from the virtual environment Activate.ps1 script
#---------------------------------------------------------------------------------------------------
<#
.Description
Get-PyVenvConfig parses the values from the pyvenv.cfg file located in the
given folder, and returns them in a map.

For each line in the pyvenv.cfg file, if that line can be parsed into exactly
two strings separated by `=` (with any amount of whitespace surrounding the =)
then it is considered a `key = value` line. The left hand string is the key,
the right hand is the value.

If the value starts with a `'` or a `"` then the first and last character is
stripped from the value before being captured.

.Parameter ConfigDir
Path to the directory that contains the `pyvenv.cfg` file.
#>
function Get-PyVenvConfig(
   [String] $ConfigDir
)
{
   Write-Verbose "Given ConfigDir=$ConfigDir, obtain values in pyvenv.cfg"

   # Ensure the file exists, and issue a warning if it doesn't (but still allow the function to continue).
   $pyvenvConfigPath = Join-Path -Resolve -Path $ConfigDir -ChildPath 'pyvenv.cfg' -ErrorAction Continue

   # An empty map will be returned if no config file is found.
   $pyvenvConfig = @{ }

   if ($pyvenvConfigPath)
   {
      Write-Verbose "File exists, parse `key = value` lines"
      $pyvenvConfigContent = Get-Content -Path $pyvenvConfigPath

      $pyvenvConfigContent | ForEach-Object {

         $keyval = $PSItem -split "\s*=\s*", 2

         if ($keyval[0] -and $keyval[1])
         {
            $val = $keyval[1]

            # Remove extraneous quotations around a string value.
            if ("'""".Contains($val.Substring(0, 1)))
            {
               $val = $val.Substring(1, $val.Length - 2)
            }

            $pyvenvConfig[$keyval[0]] = $val
            Write-Verbose "Adding Key: '$($keyval[0])'='$val'"
         }
      }
   }
   return $pyvenvConfig
}

#---------------------------------------------------------------------------------------------------
#
#---------------------------------------------------------------------------------------------------

# Move to the script directory
pushd $PSScriptRoot

# Create the virtual environment
# Uses the Windows Python launcher to determine the Python version
"Creating virtual environment"
py -3 -m venv VirtEnv

# Get the Python environment
$pyvenvCfg = Get-PyVenvConfig -ConfigDir VirtEnv

if ($pyvenvCfg -and $pyvenvCfg["home"])
{
   # Copy the Python Dlls to the virtual environment
   # This is required to support Python operations within Matlab
   "Installing Python Dlls"

   Get-ChildItem $pyvenvCfg["home"] -Filter python*.dll |
   Foreach-Object {
      $pythonDllFile = Join-Path -Resolve -Path $pyvenvCfg["home"] -ChildPath $_.Name
      "Installing $pythonDllFile"

      Copy-Item -Force -Path $pythonDllFile -Destination VirtEnv\Scripts
   }
}
else
{
   "Error - Failed to install Python Dlls"
}

# Restore the original directory
popd
