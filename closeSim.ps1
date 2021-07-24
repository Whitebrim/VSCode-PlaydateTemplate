$sim = Get-Process "PlaydateSimulator" -ErrorAction SilentlyContinue

if ($sim)
{
    $sim.CloseMainWindow()
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
else
{
    exit 0
}