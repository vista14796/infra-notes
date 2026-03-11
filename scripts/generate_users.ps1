#台湾人名前（ロマー字）：

# Part 1: Generate CSV File
$Surnames = "Chen","Lin","Huang","Zhang","Li","Wang","Wu","Liu","Tsai","Yang"
$FirstNames = "Ming","Fen","Yu","Hao","Jun","Yi","En","Jie","An","Wei"
$Departments = @("Sales", "IT")

$UserList = @()

for ($i = 1; $i -le 100; $i++) {
    $RandomName = ($Surnames | Get-Random) + "_" + ($FirstNames | Get-Random)
    $EmpID = "EMP" + $i.ToString("000")
    $Dept = if ($i -le 50) { "Sales" } else { "IT" }
    
    $UserList += [PSCustomObject]@{
        Name       = $RandomName
        EmployeeID = $EmpID
        Dept       = $Dept
        Title      = "Staff"
    }
}

$UserList | Export-Csv -Path "C:\temp\UserList.csv" -NoTypeInformation
Write-Host "CSV generated at C:\temp\UserList.csv" -ForegroundColor Cyan

}

$UserList | Export-Csv -Path "C:\temp\UserList.csv" -NoTypeInformation
Write-Host "CSV generated at C:\temp\UserList.csv" -ForegroundColor Cyan
