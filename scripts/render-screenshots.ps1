$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Drawing

$projectRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$screenshotDirectory = Join-Path $projectRoot 'screenshots'

function Read-ProjectText([string] $relativePath) {
    $fullPath = Join-Path $projectRoot $relativePath
    return [IO.File]::ReadAllText($fullPath, [Text.Encoding]::UTF8).TrimEnd([char[]] "`r`n")
}

function New-Section([string] $label, [string] $path, [bool] $isCode = $false) {
    return [pscustomobject]@{
        Label = $label
        Content = Read-ProjectText $path
        IsCode = $isCode
    }
}

$captures = @(
    [pscustomobject]@{
        File = '01-relasi-one-to-many.png'
        Title = 'Relasi one-to-many'
        Subtitle = 'belongsTo pada Pekerjaan | hasMany pada Perusahaan'
        Sections = @((New-Section 'Keluaran Tinker' 'screenshots/logs/01-one-to-many.txt'))
    },
    [pscustomobject]@{
        File = '02-lazy-loading.png'
        Title = 'Pengamatan lazy loading'
        Subtitle = 'Pekerjaan::first() dan akses perusahaan menghasilkan dua query'
        Sections = @((New-Section 'Keluaran Tinker | query log' 'screenshots/logs/02-lazy-loading.txt'))
    },
    [pscustomobject]@{
        File = '03-pivot-dan-cascade.png'
        Title = 'Pivot table dan cascade on delete'
        Subtitle = 'Lima kolom pivot | dua foreign key | tautan terhapus bersama kategori'
        Sections = @(
            (New-Section 'Struktur SQLite' 'screenshots/logs/schema-pivot.txt'),
            (New-Section 'Pemeriksaan cascade | transaksi di-rollback' 'screenshots/logs/04-cascade-check.txt')
        )
    },
    [pscustomobject]@{
        File = '04-many-to-many.png'
        Title = 'Relasi many-to-many dari dua arah'
        Subtitle = 'daftar_kategori pada Pekerjaan | daftar_pekerjaan pada Kategori'
        Sections = @((New-Section 'Keluaran Tinker' 'screenshots/logs/03-many-to-many.txt'))
    },
    [pscustomobject]@{
        File = '05-factory-dan-seeder.png'
        Title = 'Factory, attach(), dan seeder'
        Subtitle = 'make() | create(3) | timestamp pivot | empat pekerjaan x dua kategori'
        Sections = @(
            (New-Section 'Factory' 'screenshots/logs/05-factory-make-create.txt'),
            (New-Section 'Relasi pivot dan withTimestamps()' 'screenshots/logs/06-attach-programming.txt'),
            (New-Section 'Hasil akhir database' 'screenshots/logs/07-final-summary.txt')
        )
    },
    [pscustomobject]@{
        File = '06-kode-relasi.png'
        Title = 'Kode model Eloquent'
        Subtitle = 'Relasi belongsTo, hasMany, belongsToMany, dan withTimestamps()'
        Sections = @(
            (New-Section 'app/Models/Pekerjaan.php' 'app/Models/Pekerjaan.php' $true),
            (New-Section 'app/Models/Perusahaan.php' 'app/Models/Perusahaan.php' $true),
            (New-Section 'app/Models/Kategori.php' 'app/Models/Kategori.php' $true)
        )
    },
    [pscustomobject]@{
        File = '07-kode-migration-pivot.png'
        Title = 'Kode migration pivot'
        Subtitle = 'Foreign key dan cascade | urutan rollback aman'
        Sections = @((New-Section 'Migration kategoris dan pekerjaan_kategori' 'database/migrations/2026_10_04_000003_create_kategoris_and_pekerjaan_kategori_tables.php' $true))
    },
    [pscustomobject]@{
        File = '08-kode-factory-seeder.png'
        Title = 'Kode factory dan seeder kategori'
        Subtitle = 'Fake data kategori | lima kategori | dua kategori acak per pekerjaan'
        Sections = @(
            (New-Section 'database/factories/KategoriFactory.php' 'database/factories/KategoriFactory.php' $true),
            (New-Section 'database/seeders/KategoriSeeder.php' 'database/seeders/KategoriSeeder.php' $true)
        )
    },
    [pscustomobject]@{
        File = '09-kode-database-seeder.png'
        Title = 'Seeder terdaftar di DatabaseSeeder'
        Subtitle = 'Data perusahaan dan pekerjaan dibuat lebih dulu, lalu kategori dan pivot'
        Sections = @(
            (New-Section 'database/seeders/DataAwalSeeder.php' 'database/seeders/DataAwalSeeder.php' $true),
            (New-Section 'database/seeders/DatabaseSeeder.php' 'database/seeders/DatabaseSeeder.php' $true)
        )
    },
    [pscustomobject]@{
        File = '10-database-seeder-run.png'
        Title = 'Migration dan DatabaseSeeder berhasil dijalankan'
        Subtitle = 'migrate:fresh --seed membuat data awal dan menjalankan KategoriSeeder'
        Sections = @((New-Section 'Keluaran Artisan' 'screenshots/logs/migrate-fresh-seed.txt'))
    }
)

$width = 1600
$left = 54
$contentWidth = 1492
$fontTitle = [Drawing.Font]::new('Segoe UI', 30, [Drawing.FontStyle]::Bold, [Drawing.GraphicsUnit]::Pixel)
$fontSubtitle = [Drawing.Font]::new('Segoe UI', 17, [Drawing.FontStyle]::Regular, [Drawing.GraphicsUnit]::Pixel)
$fontLabel = [Drawing.Font]::new('Segoe UI', 15, [Drawing.FontStyle]::Bold, [Drawing.GraphicsUnit]::Pixel)
$fontBody = [Drawing.Font]::new('Consolas', 15, [Drawing.FontStyle]::Regular, [Drawing.GraphicsUnit]::Pixel)
$fontCode = [Drawing.Font]::new('Consolas', 14, [Drawing.FontStyle]::Regular, [Drawing.GraphicsUnit]::Pixel)
$fontFooter = [Drawing.Font]::new('Segoe UI', 13, [Drawing.FontStyle]::Regular, [Drawing.GraphicsUnit]::Pixel)

$background = [Drawing.Color]::FromArgb(11, 18, 32)
$panel = [Drawing.Color]::FromArgb(17, 27, 43)
$card = [Drawing.Color]::FromArgb(10, 17, 28)
$cardHeader = [Drawing.Color]::FromArgb(19, 30, 46)
$header = [Drawing.Color]::FromArgb(20, 46, 66)
$accent = [Drawing.Color]::FromArgb(115, 214, 196)
$text = [Drawing.Color]::FromArgb(222, 232, 244)
$muted = [Drawing.Color]::FromArgb(155, 177, 198)
$lineNumber = [Drawing.Color]::FromArgb(99, 122, 148)
$terminalText = [Drawing.Color]::FromArgb(197, 225, 203)
$border = [Drawing.Color]::FromArgb(42, 58, 78)

foreach ($capture in $captures) {
    $lineCounts = foreach ($section in $capture.Sections) {
        $count = @($section.Content -split "`n").Count
        if ($section.IsCode) { $count += 1 }
        $count
    }
    $height = [Math]::Max(1100, 274 + ($capture.Sections.Count * 74) + ((($lineCounts | Measure-Object -Sum).Sum) * 23))

    $bitmap = [Drawing.Bitmap]::new($width, $height)
    $graphics = [Drawing.Graphics]::FromImage($bitmap)
    $graphics.SmoothingMode = [Drawing.Drawing2D.SmoothingMode]::AntiAlias
    $graphics.TextRenderingHint = [Drawing.Text.TextRenderingHint]::AntiAliasGridFit

    $backgroundBrush = [Drawing.SolidBrush]::new($background)
    $panelBrush = [Drawing.SolidBrush]::new($panel)
    $cardBrush = [Drawing.SolidBrush]::new($card)
    $cardHeaderBrush = [Drawing.SolidBrush]::new($cardHeader)
    $headerBrush = [Drawing.SolidBrush]::new($header)
    $accentBrush = [Drawing.SolidBrush]::new($accent)
    $textBrush = [Drawing.SolidBrush]::new($text)
    $mutedBrush = [Drawing.SolidBrush]::new($muted)
    $lineNumberBrush = [Drawing.SolidBrush]::new($lineNumber)
    $terminalBrush = [Drawing.SolidBrush]::new($terminalText)
    $borderPen = [Drawing.Pen]::new($border, 1)

    try {
        $graphics.Clear($background)
        $graphics.FillRectangle($panelBrush, 30, 30, 1540, ($height - 60))
        $graphics.DrawRectangle($borderPen, 30, 30, 1539, ($height - 61))
        $graphics.FillRectangle($headerBrush, 31, 31, 1538, 180)
        $graphics.FillEllipse($accentBrush, 66, 60, 13, 13)
        $graphics.DrawString('MODUL 6  |  LARAVEL 12  |  BUKTI PELAKSANAAN', $fontLabel, $accentBrush, 91, 56)
        $graphics.DrawString($capture.Title, $fontTitle, $textBrush, 65, 89)
        $graphics.DrawString($capture.Subtitle, $fontSubtitle, $mutedBrush, 67, 137)

        $y = 232
        foreach ($section in $capture.Sections) {
            $lines = @($section.Content -split "`n")
            $lineHeight = if ($section.IsCode) { 19 } else { 20 }
            $bodyHeight = [Math]::Max(45, ($lines.Count * $lineHeight) + 28)
            $sectionHeight = 48 + $bodyHeight

            $graphics.FillRectangle($cardBrush, $left, $y, $contentWidth, $sectionHeight)
            $graphics.DrawRectangle($borderPen, $left, $y, $contentWidth, $sectionHeight)
            $graphics.FillRectangle($cardHeaderBrush, ($left + 1), ($y + 1), ($contentWidth - 2), 42)
            $graphics.DrawString($section.Label, $fontLabel, $mutedBrush, ($left + 18), ($y + 11))

            $bodyY = $y + 58
            for ($index = 0; $index -lt $lines.Count; $index++) {
                $line = $lines[$index].TrimEnd("`r")
                $lineBrush = if ($section.IsCode) { $textBrush } else { $terminalBrush }

                if ($section.IsCode) {
                    $graphics.DrawString(([string]($index + 1)).PadLeft(3), $fontCode, $lineNumberBrush, ($left + 17), ($bodyY + ($index * $lineHeight)))
                    $graphics.DrawString($line, $fontCode, $lineBrush, ($left + 71), ($bodyY + ($index * $lineHeight)))
                } else {
                    $graphics.DrawString($line, $fontBody, $lineBrush, ($left + 18), ($bodyY + ($index * $lineHeight)))
                }
            }

            $y += $sectionHeight + 18
        }

        $footerY = $y + 4
        $graphics.DrawString('Sumber: kode proyek dan log Artisan/Tinker tersimpan di screenshots/logs.', $fontFooter, $mutedBrush, ($left + 2), $footerY)
        $destination = Join-Path $screenshotDirectory $capture.File
        $bitmap.Save($destination, [Drawing.Imaging.ImageFormat]::Png)
        Write-Output "Created screenshots/$($capture.File)"
    } finally {
        $borderPen.Dispose()
        $backgroundBrush.Dispose()
        $panelBrush.Dispose()
        $cardBrush.Dispose()
        $cardHeaderBrush.Dispose()
        $headerBrush.Dispose()
        $accentBrush.Dispose()
        $textBrush.Dispose()
        $mutedBrush.Dispose()
        $lineNumberBrush.Dispose()
        $terminalBrush.Dispose()
        $graphics.Dispose()
        $bitmap.Dispose()
    }
}

$fontTitle.Dispose()
$fontSubtitle.Dispose()
$fontLabel.Dispose()
$fontBody.Dispose()
$fontCode.Dispose()
$fontFooter.Dispose()
