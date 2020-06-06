<###
# Parameters for System.IO.FileSystemWatcher to be constructed with
$watcherParameters = @{
    Path                    = "C:\Test"
    Filter                  = "*.bat"
    IncludeSubdirectories   = $false
    EnableRaisingEvents     = $true
}
# Triggered when a .bat file is placed in C:\Test\
$watcher  = New-Object    -ComObject System.IO.FileSystemWatcher `
                          -Property $watcherParameters
#Parameters for Register-ObjectEvent
$objEventParameters = @{
    InputObject = $watcher
    EventName = "Created"
}                           
# If you ever need to modify this, make sure to catch the registered event so you can unregister if needed.
Register-ObjectEvent  @objEventParameters
#>