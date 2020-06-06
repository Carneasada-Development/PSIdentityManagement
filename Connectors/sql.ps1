# REQUIRES .NET 4.0+
<###
$cred = Get-Credential
Add-Type -AssemblyName 
"Microsoft.SqlServer.Smo,Version=13.0.0.0,Culture=neutral,PublicKeyToken=8984
5dcd8080cc91"
$srv = New-Object Microsoft.SqlServer.Management.Smo.Server MyServer
###>
Add-Type -AssemblyName "Microsoft.SqlServer.Smo,Version=11.0.0.0,Culture=neutral,PublicKeyToken=89845dcd8080cc91"
# Once you have the assembly loaded you create an object for the SQL Server instance you want to work with:
$srv = New-Object Microsoft.SqlServer.Management.Smo.Server “localhost\sql12”
$srv.Databases | select name
# Now from there you will need to work out which task you want to perform, and find the class of objects and methods that you need. 
# It, obviously, is not the method used for quickly doing a task (at least until you get familiar with how SMO works).

# You simply create an object of System.Data.SqlClient.SqlConnection and pass the connection string that will be used #
# in order to connect to the given SQL Server instance… don’t forget to open it.
$sqlConn = New-Object System.Data.SqlClient.SqlConnection
$sqlConn.ConnectionString = “Server=localhost\sql12;Integrated Security=true;Initial Catalog=master”
$sqlConn.Open()

# You have a few options here because the SqlConnection actually contains a method that you can use to create your command object, 
# or you can create a separate object all together. 
# I have seen both options used so it is for the most part a preference.
$sqlcmd = $sqlConn.CreateCommand()
<# or #>
$sqlcmd = New-Object System.Data.SqlClient.SqlCommand
$sqlcmd.Connection = $sqlConn
$query = “SELECT name, database_id FROM sys.databases”
$sqlcmd.CommandText = $query

# By definition this object “represents a set of data commands and a database connection that are used to fill the DataSet”. 
# You create the SqlDataAdapter and pass it the previous command object created, $sqlcmd.
$adp = New-Object System.Data.SqlClient.SqlDataAdapter $sqlcmd

# This object will be the type System.Data.DataSet and as defined is simply “an in-memory cache of data”. 
# Which this is something to take note of that the query you are running has to be loaded into memory, so the larger the dataset the more memory needed.
$data = New-Object System.Data.DataSet
$adp.Fill($data) | Out-Null
# This is just my preference but when I use the “Fill” method I pipe this to Out-Null simply because this method will output the number of records it filled. 
# If you want that output just remove the Out-Null.

# After you do all that you are probably wondering how you output that data so you can see it? 
# The data itself resides in a collection of tables within the Table property of your DataSet object. 
# Now depending on the version of .NET you are working with you might actually need to specify the index of the collection (e.g. Tables[0]), 
# but this is generally only required in older versions below .NET 4.0.
$data.Tables
<# or #>
$data.Tables[0]
# If the procedure or T-SQL script you are executing contains more than one dataset this collection will only contain the first result set returned by SQL Server.