<###
Method 1: Install dbatools from the PowerShell Gallery on newer systems
    The PowerShell Gallery and the command Install-Module are natively available in Windows 10+ and Windows Server 2016+. 
    If you run Windows 7, 8, Server 2012 skip to method 2.
    Install-Module dbatools
    Install-Module requires Run As Administrator, and installs dbatools globally. 
                            Don’t have admin access or want to install dbatools only for yourself?
    Install-Module dbatools -Scope CurrentUser

Method 2: Install dbatools from the PowerShell Gallery on older systems
    If you run Windows 7, 8, Server 2012 & below you can either install PackageManagement from powershellgallery.com.
    First, install WMF5 from https://aka.ms/wmf5download then reboot the computer.
    Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
    Install-Module dbatools #Run as admin
    Install-Module dbatools -Scope CurrentUser #Local Scope

Method 3: For legacy (Win7, Win8, etc) systems: scripted installer directly from GitHub
    Invoke-Expression (Invoke-WebRequest -UseBasicParsing https://dbatools.io/in)
        Install location: DocumentsWindowsPowerShellModules

Method 4: Download the zip directly and manually import the module.
    Once you’ve extracted the folder, make sure you rename it from dbatools-master or dbatools-development to plain o’ dbatools and place it somewhere in $env:PSMODULEPATH.
    GitHub via dbatools.io/zip
            You can also easily download the latest version of our master GitHub repository by simply clicking on dbatools.io/zip. 
            Note that there is a small difference between our GitHub repo and the PowerShell Gallery. 
            The GitHub repo does not include a pre-compiled version of our library (dbatools.dll), while the PowerShell Gallery does. 
            Ultimately, both ways work and there’s really no difference. Excluding the dll from the GitHub repo just made it easier for our developers to avoid conflicts.
    You can also use PowerShell to download the module and rename it, all in one shot.
        Invoke-WebRequest -Uri powershellgallery.com/api/v2/package/dbatools -OutFile c:\temp\dbatools.zip
        Invoke-WebRequest is a bit slow, however, because of the progress bar, so I usually just download via GUI and rename.

Method 5: Clone the repository from GitHub
    git clone https://github.com/sqlcollaborative/dbatools

Method 6: Offline install
Don’t have Internet access on your DBA workstation? Check out our offline install guide.

    From PowerShell Gallery using Save-Module
    From PowerShell Gallery by downloading from powershellgallery.com/api/v2/package/dbatools
    Once the file has been downloaded, copy it to your secure server and place it in one of the directories in your $env:PSModulePath (type $env:PSModulePath at the prompt and press enter). 
    This will allow PowerShell to autoload the module, saving you from having to Import-Module each time you start a new session.
    Invoke-WebRequest -Uri powershellgallery.com/api/v2/package/dbatools -OutFile c:\temp\dbatools.zip
    Invoke-WebRequest is a bit slow, however, because of the progress bar, so I usually just download via GUI and rename.

    Method 1
        If you run Windows 10 or Windows Server 2016, you’ve already got support for the Gallery and can just issue the following command.
        Save-Module -Name dbatools -Path C:\temp
        This will download the package, unzip it and place it into C:\temp\dbatools. Saving modules and investigating their content is actually a recommended practice by the PowerShell team, as it’s always good to know what you’re installing on your system.

    Method 2
        If your system is older and you do not have PowerShellGet or you haven’t upgraded to PowerShell 5.1 (which comes with PowerShellGet), 
        then you can just download the zip directly from the Gallery’s API.
        Note that this will download a file ending in .nupkg. Simply rename the file to .zip, extract and you’re set. 

Method 7: chocolatey!
    Now, you can even install dbatools using chocolatey:
    choco install dbatools
#>