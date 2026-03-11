# Part 2: Batch Import to NewUsers OU
Import-Module ActiveDirectory

$CSVPath = "C:\temp\UserList.csv"
$TargetOU = "OU=NewUsers,DC=auto,DC=local" 

$UserData = Import-Csv -Path $CSVPath

foreach ($User in $UserData) {
    try {
        $SecurePassword = ConvertTo-SecureString "2Password!" -AsPlainText -Force
        
        $Params = @{
            Name                  = $User.Name
            SamAccountName        = $User.EmployeeID
            UserPrincipalName     = "$($User.EmployeeID)@auto.local" 
            Path                  = $TargetOU
            Department            = $User.Dept    
            Title                 = $User.Title
            Enabled               = $true
            AccountPassword       = $SecurePassword
            ChangePasswordAtLogon = $true 
        }
        
        New-ADUser @Params
        Write-Host "Success: $($User.Name) added to $($User.Dept)" -ForegroundColor Green
    }
    catch {
        Write-Warning "Failed: $($User.Name). Reason: $($_.Exception.Message)"
    }
}
