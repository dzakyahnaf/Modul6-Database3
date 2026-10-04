$ErrorActionPreference = 'Stop'

$root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$docs = Join-Path $root 'docs'
$outputDocx = Join-Path $docs 'Laporan-Praktikum-Modul-6.docx'
$outputPdf = Join-Path $docs 'Laporan-Praktikum-Modul-6.pdf'
$temporaryHtml = Join-Path $docs 'Laporan-Praktikum-Modul-6-source.html'
$author = 'Herlina Dwi Septiana'
$date = '4 Oktober 2026'

$groups = @(
    @{ Title = 'Relasi one-to-many dan lazy loading'; Files = @('01-relasi-one-to-many.png', '02-lazy-loading.png'); Captions = @('Relasi belongsTo dan hasMany berhasil dibaca melalui Tinker.', 'Log query menunjukkan dua query sejak pekerjaan diambil hingga perusahaan diakses.') },
    @{ Title = 'Pivot table, cascade, dan many-to-many'; Files = @('03-pivot-dan-cascade.png', '04-many-to-many.png'); Captions = @('Skema pivot dan pemeriksaan cascade on delete.', 'Relasi belongsToMany dapat dibaca dari kedua model.') },
    @{ Title = 'Factory, attach, dan eksekusi seeder'; Files = @('05-factory-dan-seeder.png', '10-database-seeder-run.png'); Captions = @('Bukti make(), create(), dan hasil pengisian kategori.', 'migrate:fresh --seed menyelesaikan migration serta kedua seeder.') },
    @{ Title = 'Bukti kode model dan migration pivot'; Files = @('06-kode-relasi.png', '07-kode-migration-pivot.png'); Captions = @('Implementasi belongsTo, hasMany, dan belongsToMany.', 'Migration kategoris dan pekerjaan_kategori dengan foreign key cascade.') },
    @{ Title = 'Bukti kode factory dan seeder'; Files = @('08-kode-factory-seeder.png', '09-kode-database-seeder.png'); Captions = @('Factory kategori dan seeder yang memasangkan dua kategori ke tiap pekerjaan.', 'DataAwalSeeder dan pendaftaran KategoriSeeder pada DatabaseSeeder.') }
)

$evidencePages = [System.Collections.Generic.List[string]]::new()
for ($i = 0; $i -lt $groups.Count; $i++) {
    $group = $groups[$i]
    $figures = [System.Collections.Generic.List[string]]::new()
    for ($j = 0; $j -lt $group.Files.Count; $j++) {
        $relativePath = Join-Path $root (Join-Path 'screenshots' $group.Files[$j])
        $imagePath = (Resolve-Path -LiteralPath $relativePath).Path
        $imageUri = ([System.Uri]::new($imagePath)).AbsoluteUri
        $caption = [System.Net.WebUtility]::HtmlEncode($group.Captions[$j])
        $alt = [System.Net.WebUtility]::HtmlEncode($group.Files[$j])
        $number = ($i * 2) + $j + 1
        $figures.Add("<figure><img src=`"$imageUri`" alt=`"$alt`" /><figcaption><strong>Bukti $number.</strong> $caption</figcaption></figure>")
    }
    $evidencePages.Add("<section class=`"evidence-page`"><h2>$($group.Title)</h2>$($figures -join "`n")</section>")
}

$template = @'
<!doctype html>
<html lang="id">
<head>
<meta charset="utf-8" />
<title>Laporan Praktikum Modul 6 - Herlina Dwi Septiana</title>
<style>
@page { size: A4; margin: 15mm 16mm 17mm 16mm; }
body { font-family: Arial, Calibri, sans-serif; color: #253247; font-size: 10pt; line-height: 1.32; }
h1, h2, h3 { color: #18385a; page-break-after: avoid; }
h1 { font-size: 21pt; margin: 0 0 8pt; }
h2 { font-size: 15pt; margin: 14pt 0 7pt; border-bottom: 1.5pt solid #54b7ad; padding-bottom: 4pt; }
h3 { font-size: 11pt; margin: 10pt 0 4pt; }
p { margin: 0 0 6pt; text-align: justify; }
ul, ol { margin-top: 2pt; margin-bottom: 7pt; }
li { margin-bottom: 3pt; }
table { border-collapse: collapse; width: 100%; margin: 7pt 0 10pt; font-size: 9pt; page-break-inside: avoid; }
th, td { border: 0.7pt solid #b8c5d1; padding: 5pt 6pt; vertical-align: top; }
th { background: #18385a; color: #ffffff; text-align: left; }
.cover { text-align: center; padding-top: 115pt; page-break-after: always; }
.cover .eyebrow { color: #318c88; letter-spacing: 1.5pt; font-size: 10pt; font-weight: bold; }
.cover h1 { margin-top: 38pt; font-size: 31pt; letter-spacing: 1pt; }
.cover h1 span { color: #318c88; }
.cover h2 { display: inline-block; border: 0; font-size: 19pt; letter-spacing: 2pt; margin: 4pt 0; }
.cover .subtitle { text-align: center; color: #5d6b7e; font-size: 13pt; margin: 8pt 0 26pt; }
.cover .rule { width: 70pt; border-top: 3pt solid #54b7ad; margin: 0 auto 30pt; }
.cover .author { font-size: 16pt; font-weight: bold; color: #18385a; margin-bottom: 6pt; }
.cover .meta { font-size: 10pt; color: #526174; text-align: center; line-height: 1.6; }
.callout { background: #eef7f6; border-left: 3pt solid #54b7ad; padding: 8pt 10pt; margin: 8pt 0; }
.code { font-family: Consolas, 'Courier New', monospace; font-size: 8.5pt; background: #f1f4f7; border: 0.5pt solid #d5dde5; padding: 7pt; white-space: pre-wrap; margin: 5pt 0 8pt; }
.small { color: #59697a; font-size: 8.5pt; }
.page-break { page-break-before: always; }
.evidence-page { page-break-before: always; }
.evidence-page h2 { margin-top: 0; margin-bottom: 7pt; }
figure { margin: 5pt 0 9pt; text-align: center; page-break-inside: avoid; }
figure + figure { page-break-before: always; }
figure img { width: 540px; max-width: 100%; height: auto; }
figcaption { text-align: left; color: #4c5c6c; font-size: 8.5pt; margin-top: 3pt; }
.check { font-family: Arial, sans-serif; }
</style>
</head>
<body>
<section class="cover">
  <div class="eyebrow">PRAKTIKUM PEMROGRAMAN 2 &nbsp; | &nbsp; SEMESTER 5</div>
  <h1>LAPORAN PRAKTIKUM<br /><span>MODUL 6</span></h1>
  <h2>DATABASE 3</h2>
  <p class="subtitle">Eloquent Relationship, Pivot Table, Factory, dan Seeder</p>
  <div class="rule"></div>
  <p class="small">Disusun oleh</p>
  <p class="author">__AUTHOR__</p>
  <p class="meta">Laravel 12 &nbsp; | &nbsp; PHP 8.2 &nbsp; | &nbsp; SQLite<br />__DATE__</p>
</section>

<h1>1. Pendahuluan</h1>
<p>Praktikum Modul 6 membahas pemodelan hubungan antar tabel menggunakan Eloquent, pengamatan lazy loading, pembuatan tabel pivot many-to-many, serta pembuatan data uji dengan factory dan seeder. Laporan ini mencatat implementasi pada proyek Laravel, hasil yang diamati melalui Tinker dan Artisan, serta bukti pelaksanaan.</p>
<h2>Tujuan</h2>
<ul>
  <li>Memahami perbedaan relasi one-to-one, one-to-many, dan many-to-many.</li>
  <li>Mendefinisikan serta menguji relasi <code>belongsTo</code>, <code>hasMany</code>, dan <code>belongsToMany</code>.</li>
  <li>Menghitung query yang dijalankan pada lazy loading.</li>
  <li>Membuat pivot dengan foreign key dan aturan <code>cascadeOnDelete</code>.</li>
  <li>Menggunakan <code>make()</code>, <code>create()</code>, <code>attach()</code>, factory, dan seeder untuk menghasilkan data uji.</li>
</ul>
<h2>Lingkup dan lingkungan</h2>
<table><tr><th>Komponen</th><th>Hasil praktikum</th></tr>
<tr><td>Framework dan database</td><td>Laravel 12.56, PHP 8.2, SQLite.</td></tr>
<tr><td>Data awal</td><td>3 perusahaan dan 4 pekerjaan; PT Nusa Teknologi memiliki Software Engineer serta Data Analyst.</td></tr>
<tr><td>Model yang diuji</td><td><code>Perusahaan</code>, <code>Pekerjaan</code>, dan <code>Kategori</code>.</td></tr>
<tr><td>Bukti</td><td>10 screenshot hasil Artisan/Tinker dan tangkapan kode, beserta log teks pendukung.</td></tr></table>

<h1>2. Dasar Relasi dan Rancangan Basis Data</h1>
<p>Eloquent mengubah hubungan basis data menjadi method pada model. Pada relasi one-to-one, model induk memakai <code>hasOne</code> dan model anak memakai <code>belongsTo</code>. Pada one-to-many, model anak memakai <code>belongsTo</code> untuk membaca induknya, sedangkan model induk memakai <code>hasMany</code> untuk membaca collection anak. Relasi many-to-many memakai <code>belongsToMany</code> pada kedua model dan memerlukan tabel perantara.</p>
<table><tr><th>Relasi</th><th>Model</th><th>Method</th><th>Foreign key / tabel perantara</th></tr>
<tr><td>One-to-one</td><td>Contoh umum: Pengguna dan Profil</td><td><code>hasOne</code> / <code>belongsTo</code></td><td>Foreign key di tabel profil; tanpa pivot.</td></tr>
<tr><td>One-to-many</td><td>Pekerjaan ke Perusahaan</td><td><code>belongsTo</code></td><td><code>pekerjaan.perusahaan_id</code></td></tr>
<tr><td>One-to-many</td><td>Perusahaan ke Pekerjaan</td><td><code>hasMany</code></td><td><code>pekerjaan.perusahaan_id</code></td></tr>
<tr><td>Many-to-many</td><td>Pekerjaan dan Kategori</td><td><code>belongsToMany</code></td><td><code>pekerjaan_kategori</code></td></tr></table>
<p>Pivot <code>pekerjaan_kategori</code> menyimpan <code>pekerjaan_id</code>, <code>kategori_id</code>, dan timestamps. Kedua foreign key menggunakan constraint dengan cascade on delete. Method <code>down()</code> menghapus pivot sebelum tabel kategori agar rollback dapat dijalankan dalam urutan yang aman.</p>
<div class="callout"><strong>Konvensi nama pivot.</strong> Secara default Laravel mengurutkan nama model singular secara alfabetis dan akan mencari <code>kategori_pekerjaan</code>. Karena migration proyek memakai <code>pekerjaan_kategori</code>, nama tersebut diberikan eksplisit sebagai argumen kedua <code>belongsToMany()</code> pada kedua model.</div>

<h1>3. Hasil Pelaksanaan</h1>
<h2>3.1 Relasi one-to-many</h2>
<p>Model <code>Pekerjaan</code> mendefinisikan <code>perusahaan(): BelongsTo</code> melalui <code>belongsTo(Perusahaan::class)</code>. Model <code>Perusahaan</code> mendefinisikan <code>pekerjaan(): HasMany</code> melalui <code>hasMany(Pekerjaan::class)</code>. Pengujian Tinker menampilkan Software Engineer, perusahaan PT Nusa Teknologi, dan dua pekerjaan milik perusahaan tersebut.</p>
<h2>3.2 Lazy loading</h2>
<p>Pengamatan dari <code>Pekerjaan::first()</code> sampai <code>$kerja-&gt;perusahaan-&gt;nama</code> menghasilkan <strong>dua query</strong>. Query pertama mengambil satu baris pekerjaan. Query kedua baru mengambil perusahaan ketika properti relasi diakses. Setelah relasi dimuat, pembacaan atribut <code>nama</code> memakai objek yang sudah tersimpan pada model sehingga tidak menghasilkan query ketiga.</p>
<table><tr><th>Urutan</th><th>Query yang diamati</th><th>Jumlah</th></tr>
<tr><td>1</td><td><code>select * from pekerjaan limit 1</code></td><td>1</td></tr>
<tr><td>2</td><td><code>select * from perusahaan where id = ? limit 1</code></td><td>1</td></tr>
<tr><td><strong>Total</strong></td><td>Relasi perusahaan dimuat saat pertama kali diakses.</td><td><strong>2 query</strong></td></tr></table>

<h2>3.3 Pivot table dan cascade on delete</h2>
<p>Migration membuat tabel <code>kategoris</code> dan <code>pekerjaan_kategori</code>. Foreign key pivot mengarah ke tabel induk yang tepat dan menggunakan <code>cascadeOnDelete()</code>. Uji penghapusan menunjukkan tautan pivot ikut terhapus; uji dibungkus transaksi lalu di-rollback agar data praktikum tetap utuh.</p>
<h2>3.4 Relasi many-to-many</h2>
<p>Relasi <code>daftar_kategori()</code> pada Pekerjaan dan <code>daftar_pekerjaan()</code> pada Kategori menggunakan tabel pivot eksplisit <code>pekerjaan_kategori</code> dan <code>withTimestamps()</code>. Tinker berhasil menampilkan kategori dari pekerjaan serta pekerjaan dari kategori. Kolom waktu pivot terisi saat relasi baru dibuat.</p>

<h2>3.5 Factory, attach, dan seeder</h2>
<p><code>KategoriFactory</code> memakai <code>fake()-&gt;unique()-&gt;word()</code>. Pemanggilan <code>make()</code> hanya menghasilkan objek di memori tanpa menyimpan baris, sedangkan <code>create()</code> menyimpan model; pengujian <code>count(3)-&gt;create()</code> menambah tiga kategori.</p>
<p>Kategori <code>programming</code> dibuat melalui factory dan ditautkan ke pekerjaan pertama memakai <code>attach()</code>. Timestamps pada pivot terisi. <code>KategoriSeeder</code> membuat lima kategori dan memasangkan dua kategori acak dengan setiap pekerjaan.</p>
<table><tr><th>Tahap</th><th>Kategori</th><th>Baris pivot</th><th>Penjelasan</th></tr>
<tr><td><code>migrate:fresh --seed</code></td><td>5</td><td>8</td><td>4 pekerjaan x 2 kategori per pekerjaan.</td></tr>
<tr><td>Uji Tinker tambahan</td><td>+4</td><td>+1</td><td>3 dari <code>create()</code>, 1 kategori programming, dan 1 tautan <code>attach()</code>.</td></tr>
<tr><td><strong>Ringkasan sesi lengkap</strong></td><td><strong>9</strong></td><td><strong>9</strong></td><td>5 + 3 + 1 kategori; 8 + 1 tautan pivot.</td></tr></table>
<p>Seeder didaftarkan di <code>DatabaseSeeder</code> setelah <code>DataAwalSeeder</code>. Dengan demikian <code>php artisan migrate:fresh --seed</code> mengulang migration, membuat data awal, lalu menjalankan <code>KategoriSeeder</code>. Angka 5 kategori dan 8 pivot adalah hasil seed otomatis; angka 9 kategori dan 9 pivot adalah ringkasan setelah langkah Tinker tambahan pada sesi praktikum.</p>

<h1>4. Evaluasi Capaian</h1>
<table><tr><th>No.</th><th>Capaian pada modul</th><th>Status dan bukti</th></tr>
<tr><td>1</td><td><code>belongsTo</code> pada Pekerjaan berhasil diakses melalui Tinker.</td><td>[x] Tercapai - Bukti 1.</td></tr>
<tr><td>2</td><td><code>hasMany</code> mengembalikan lebih dari satu record.</td><td>[x] Tercapai - dua pekerjaan pada perusahaan pertama; Bukti 1.</td></tr>
<tr><td>3</td><td>Lazy loading dijelaskan beserta jumlah query.</td><td>[x] Tercapai - 2 query; Bukti 2.</td></tr>
<tr><td>4</td><td>Pivot pekerjaan_kategori dibuat dengan struktur yang benar.</td><td>[x] Tercapai - Bukti 3 dan 8.</td></tr>
<tr><td>5</td><td>Penghapusan kategori menghapus baris pivot secara otomatis.</td><td>[x] Tercapai - diuji dengan cascade; Bukti 3.</td></tr>
<tr><td>6</td><td><code>belongsToMany</code> berhasil dari kedua arah.</td><td>[x] Tercapai - Bukti 4 dan 7.</td></tr>
<tr><td>7</td><td>Factory diuji melalui <code>make()</code> dan <code>create()</code>.</td><td>[x] Tercapai - Bukti 5 dan 9.</td></tr>
<tr><td>8</td><td>Seeder mengisi kategori dan pivot secara otomatis.</td><td>[x] Tercapai - 5 kategori, 8 pivot; Bukti 5, 6, dan 10.</td></tr></table>
<h2>File implementasi</h2>
<p>Relasi berada pada <code>app/Models/Perusahaan.php</code>, <code>Pekerjaan.php</code>, dan <code>Kategori.php</code>. Migration pivot berada pada <code>database/migrations/2026_10_04_000003_create_kategoris_and_pekerjaan_kategori_tables.php</code>. Factory dan seeder berada pada <code>database/factories/KategoriFactory.php</code> serta folder <code>database/seeders/</code>. Skrip Tinker dan log perintah disertakan pada folder <code>scripts/tinker/</code> dan <code>screenshots/logs/</code>.</p>

<h1>5. Kesimpulan</h1>
<p>Seluruh capaian evaluasi Modul 6 berhasil dilaksanakan. Relasi one-to-many dapat dibaca dari kedua arah, lazy loading pada contoh ini menjalankan dua query, dan relasi many-to-many berjalan melalui pivot dengan foreign key serta cascade on delete. Factory membedakan objek sementara dari data tersimpan, sedangkan seeder menghasilkan lima kategori dan delapan tautan pivot untuk empat pekerjaan. Penggunaan nama pivot eksplisit dan timestamps membuat relasi sesuai skema yang dirancang.</p>
<p class="small">Rujukan: Modul 06 Database 3 (Eloquent Relationship, Pivot Table, Factory, dan Seeder); kode Laravel, keluaran Artisan/Tinker, serta screenshot pada proyek praktikum ini.</p>

__EVIDENCE_PAGES__
</body>
</html>
'@

$html = $template.Replace('__AUTHOR__', [System.Net.WebUtility]::HtmlEncode($author))
$html = $html.Replace('__DATE__', [System.Net.WebUtility]::HtmlEncode($date))
$html = $html.Replace('__EVIDENCE_PAGES__', ($evidencePages -join "`n"))
[System.IO.File]::WriteAllText($temporaryHtml, $html, [System.Text.UTF8Encoding]::new($true))
foreach ($output in @($outputDocx, $outputPdf)) {
    if (Test-Path -LiteralPath $output) { Remove-Item -LiteralPath $output -Force }
}

$pythonCandidates = [System.Collections.Generic.List[string]]::new()
$pythonCommand = Get-Command python.exe -ErrorAction SilentlyContinue
if ($pythonCommand) { $pythonCandidates.Add($pythonCommand.Source) }
foreach ($version in @('3.11.8', '3.13.3')) {
    $pythonCandidates.Add((Join-Path $env:USERPROFILE ".pyenv\pyenv-win\versions\$version\python.exe"))
}
$pythonPath = $null
foreach ($candidate in $pythonCandidates) {
    if (-not (Test-Path -LiteralPath $candidate)) { continue }
    $env:PYTHONPATH = (Join-Path $PSScriptRoot '.report-libs')
    $probeExitCode = 1
    try {
        & $candidate -c 'import docx' 2>&1 | Out-Null
        $probeExitCode = $LASTEXITCODE
    }
    catch { $probeExitCode = 1 }
    if ($probeExitCode -eq 0) { $pythonPath = $candidate; break }
}
if (-not $pythonPath) {
    throw 'Python with python-docx is required. Install it with: python -m pip install -r scripts/requirements-report.txt'
}
$converter = Join-Path $PSScriptRoot 'html_to_docx.py'
& $pythonPath $converter $temporaryHtml $outputDocx
if ($LASTEXITCODE -ne 0 -or -not (Test-Path -LiteralPath $outputDocx)) { throw 'DOCX conversion failed.' }

$edgeCandidates = @(
    'C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe',
    'C:\Program Files\Microsoft\Edge\Application\msedge.exe'
)
$edgePath = $edgeCandidates | Where-Object { Test-Path -LiteralPath $_ } | Select-Object -First 1
if (-not $edgePath) { throw 'Microsoft Edge is required to export the PDF from the report HTML.' }
$edgeProfile = Join-Path $env:TEMP ('modul6-report-edge-' + [guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $edgeProfile -Force | Out-Null
$htmlUri = ([System.Uri]::new($temporaryHtml)).AbsoluteUri
& $edgePath --headless=old --disable-gpu --disable-gpu-compositing --disable-3d-apis --in-process-gpu --disable-features=VizDisplayCompositor --disable-extensions --no-first-run --no-default-browser-check --no-pdf-header-footer "--user-data-dir=$edgeProfile" "--print-to-pdf=$outputPdf" $htmlUri
$pdfReady = $false
for ($attempt = 0; $attempt -lt 20; $attempt++) {
    if (Test-Path -LiteralPath $outputPdf) {
        $firstSize = (Get-Item -LiteralPath $outputPdf).Length
        if ($firstSize -ge 5000) {
            Start-Sleep -Milliseconds 500
            $secondSize = (Get-Item -LiteralPath $outputPdf).Length
            if ($firstSize -eq $secondSize) { $pdfReady = $true; break }
        }
    }
    Start-Sleep -Milliseconds 500
}
if (-not $pdfReady) { throw 'PDF export failed.' }

Remove-Item -LiteralPath $temporaryHtml -Force
Get-Item -LiteralPath $outputDocx, $outputPdf | Select-Object FullName, Length
