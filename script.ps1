# 🌐 CSV URL and local file paths
$csvUrl = "http://storage.googleapis.com/play_public/supported_devices.csv"
$csvPath = "supported_devices.csv"
$outputPath = "DeviceIdentifiers.Net/DeviceLookup.Generated.cs"

# ⏳ Step 1: Download CSV
Write-Host "`n🌟 Downloading CSV from $csvUrl..." -ForegroundColor Cyan
Invoke-WebRequest -Uri $csvUrl -OutFile $csvPath -UseBasicParsing
Write-Host "✅ Download complete. File saved at $csvPath." -ForegroundColor Green

# 📥 Step 2: Read CSV
Write-Host "📂 Reading CSV..." -ForegroundColor Cyan
$lines = Import-Csv $csvPath
Write-Host "✅ Loaded $($lines.Count) records." -ForegroundColor Green

# 🔧 Step 3: Generate C# cases efficiently
Write-Host "⚡ Generating C# cases..." -ForegroundColor Cyan

# Using StringBuilder for efficiency
$sb = [System.Text.StringBuilder]::new()
$i = 0

# Loop through each record
foreach ($line in $lines) {
    $i++
    # Escape quotes for valid C# strings
    $model = $line.Model.Replace('"', '\"')
    $name  = $line.'Marketing Name'.Replace('"', '\"')
    
    # Append a single line to the StringBuilder
    $null = $sb.AppendLine("            `"$model`" => `"$name`",")

    # Show progress every 500 records to avoid slowdown
    if ($i % 500 -eq 0) {
        Write-Progress -Activity "Generating cases" -Status "Processed $i of $($lines.Count)" -PercentComplete (($i / $lines.Count) * 100)
    }
}

Write-Progress -Activity "Generating cases" -Completed -Status "Done!"
# 📄 Step 4: Build the final C# class
Write-Host "🛠 Building C# class..." -ForegroundColor Cyan

# هیچ کاری برای حذف کاما نکن، فقط trim انتهای متن برای فاصله و newline
$casesText = $sb.ToString().TrimEnd()

$class = @"
namespace DeviceIdentifiers.Net
{
    public static partial class DeviceLookup
    {
        public static string? GetMarketingName(string model) => model switch
        {
$casesText
            _ => null
        };
    }
}
"@


# 💾 Step 5: Save the output to a file
Write-Host "💽 Saving output file to $outputPath..." -ForegroundColor Cyan
Set-Content -Path $outputPath -Value $class -Encoding UTF8
Write-Host "🎉 Done! Output file created successfully." -ForegroundColor Green