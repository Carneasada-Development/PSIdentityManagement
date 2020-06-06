# If you're using a csv object as well you can make an ad object and compare the two to get the set of users/properties to make changes to and it's dynamic.
Naw something that is working with the specific objects themselves. 
Since you can pull properties from objects dynamically and compare properties with a property mapping between both applications, if changed -> update. 
If you want to create provisioning for new users / user deletion, you can easily have one of the applications be source for whether or not a user is in the system, and update the other applications accordingly to current business processes.


# How will system work?
# Requirements
    - PS 3.0+
    - Windows 7+
# Future Requirements
    - If-on Linux, Mac PS 6.1+
# Connected Databases
 - Create local sql server
 - Work with DBAtools to manage sql server

Task = [PSCustomObject] Returned from connector event
- All application objects return [PSCustomObject]__App
- Handler(s) to handle [PSCustomObject]__App
- All connector objects return [PSCustomObject]__Connector
- Handler(s) to handle [PSCustomObject]__Connector

OBJECT [FileWatcher]{ File watcher looks at .csv files in folder every X seconds. }    
OBJECT [Connector]{ Connector watches change in system every X seconds. }
OBJECT [SQLServer] { <### SQLPS Module
                        Importing the SQLPS module into a PS session provides the same access using the utility does, but allows you to operate in the PS version of the OS you operate under. In SQL Server 2008 and 2008 R2 you will load the SQLPS as a snap-in (Add-PSSnapin), then with SQL Server 2012 and up it is imported (Import-Module). ###>
    }
OBJECT [SQLConnector] { 
    FUNC CreateDB               { Creates cache / temp database to use }
    PROPERTY OF CreateDB        { Specify x amount of temp dbs to keep }
    FUNC RemoveDB               { Removes cache / temp database }
    FUNC GetDB                  { Returns an object built from database }
}
OBJECT [MemoryManagement] {
    PROPERTY MemorySchema   { Gets memory schema for application }
    FUNC GetActiveMemory    { Compares Application Folder to }
}        
START THREAD FROM [FileWatcher] EVENTS  {   Line up .CSV as jobs to process
                                            After .csv is processed log, flags for deletion, moving, or nothing }
START THREAD [ThreadA] FROM [Connector] EVENTS {    if TRUE [MemoryManagement].GetActiveMemory ( )
                                                    [SQLConnector].CreateDB( properties to use )
                                                    else THROW }                               
START THREAD [ThreadB] FROM [ThreadA] { After creation, update main database / master connected database }