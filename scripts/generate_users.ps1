先確定DC建立AD帳號時的格式是否一致

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


以下為中文：


# Part 1: Generate CSV File
$Surnames = "陳","林","黃","張","李","王","吳","劉","蔡","楊"
$FirstNames = "志明","雅婷","冠宇","淑芬","家豪","怡君","俊宏","欣怡","承恩","詠潔"
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
