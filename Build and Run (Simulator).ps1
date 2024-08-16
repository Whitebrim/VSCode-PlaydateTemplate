 param (
    [string]$build = ".\builds",
    [string]$source = ".\Source",
    [string]$name = (Get-Item -Path .).BaseName,
    [switch]$dontbuild = $false
 )

# Close Simulator
$sim = Get-Process "PlaydateSimulator" -ErrorAction SilentlyContinue

if ($sim)
{
    $sim | Stop-Process
    $count = 0
    while (!$sim.HasExited) 
    {
        Start-Sleep -Milliseconds 10
        $count += 1

        if ($count -ge 5)
        {
            $sim | Stop-Process -Force
        }
    }
}

$pdx = Join-Path -Path "$build" -ChildPath "$name.pdx"

# Create build folder if not present
if (!$dontbuild)
{
    New-Item -ItemType Directory -Force -Path "$build"
}

# Clean build folder
if (!$dontbuild)
{
    Remove-Item "$build\*" -Recurse -Force 
}

# Build
if (!$dontbuild)
{
    pdc -sdkpath "$Env:PLAYDATE_SDK_PATH" "$source" "$pdx"
}

# Run (Simulator)
& "$Env:PLAYDATE_SDK_PATH\bin\PlaydateSimulator.exe" "$pdx"
