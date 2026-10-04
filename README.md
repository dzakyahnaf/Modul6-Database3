# Modul 6 Database 3 — Eloquent Relationship, Pivot Table, Factory, dan Seeder

Proyek Laravel ini mengerjakan praktikum pada PDF Modul 6. Kode mencakup relasi `belongsTo`, `hasMany`, dan `belongsToMany`, pivot table dengan foreign key cascade, factory kategori, dan seeder. Data demo disimpan pada SQLite.

Checklist delapan capaian PDF ada di [docs/CHECKLIST.md](docs/CHECKLIST.md). Laporan formal atas nama Herlina Dwi Septiana tersedia sebagai [DOCX](docs/Laporan-Praktikum-Modul-6.docx) dan [PDF](docs/Laporan-Praktikum-Modul-6.pdf); jawaban ringkas pengamatan ada di [docs/laporan-praktikum.md](docs/laporan-praktikum.md). Bukti berupa PNG dan log keluaran ada di `screenshots/`.

PNG bukti merender keluaran Artisan/Tinker yang benar-benar dijalankan dan kode pada berkas proyek. Log teks mentah disertakan supaya hasilnya mudah dicocokkan.

## Menjalankan proyek

Di PowerShell, dari folder proyek:

```powershell
composer install
Copy-Item .env.example .env
New-Item -ItemType File -Path database/database.sqlite -Force
php artisan key:generate
php artisan migrate:fresh --seed
```

Perintah seed menambahkan tiga perusahaan, empat pekerjaan, satu user bawaan Laravel, lima kategori, dan delapan baris pivot. Data contoh memiliki dua pekerjaan pada perusahaan pertama sehingga `hasMany` langsung terlihat.

Untuk mencoba Tinker secara interaktif:

```powershell
.\scripts\tinker.ps1
```

Lalu jalankan contoh berikut satu per satu:

```php
$kerja = App\Models\Pekerjaan::first();
$kerja->perusahaan;
$kerja->perusahaan->nama;

$perusahaan = App\Models\Perusahaan::first();
$perusahaan->pekerjaan;

App\Models\Kategori::factory()->make();
App\Models\Kategori::factory()->count(3)->create();

$kerja = App\Models\Pekerjaan::first();
$kategori = App\Models\Kategori::factory()->create(['name' => 'programming']);
$kerja->daftar_kategori()->attach($kategori->id);
$kerja->daftar_kategori;
$kategori->daftar_pekerjaan;
```

Untuk mengikuti urutan sesi factory dan seeder pada PDF, jalankan contoh Tinker tersebut setelah `migrate:fresh --seed`, lalu jalankan:

```powershell
php artisan db:seed --class=KategoriSeeder
```

Seeder kategori menambahkan lima kategori dan dua tautan untuk setiap pekerjaan. Dengan empat pekerjaan, seeder menambahkan delapan baris ke pivot. Jika langkah `make()`/`create()` dan kategori `programming` juga dijalankan, hasil akhirnya sembilan kategori dan sembilan baris pivot.

File `scripts/tinker.ps1` mengarahkan riwayat PsySH ke penyimpanan proyek bila pembatasan lingkungan mencegah penulisan ke profil Windows. Contoh perintah Tinker yang menghasilkan bukti tersimpan di `scripts/tinker/`.

PNG bukti dapat dibuat ulang dari log Artisan/Tinker dan kode proyek dengan `.\scripts\render-screenshots.ps1` pada Windows.

## Susunan kode

- `app/Models/`: model `Perusahaan`, `Pekerjaan`, dan `Kategori`.
- `database/migrations/`: skema perusahaan, pekerjaan, kategori, dan pivot.
- `database/factories/KategoriFactory.php`: factory kategori dengan kata unik.
- `database/seeders/`: data awal dan `KategoriSeeder`.
- `scripts/tinker/`: perintah pengamatan yang dapat dijalankan melalui `php artisan tinker`.
- `screenshots/`: gambar bukti dan log mentah yang diambil dari keluaran proyek.

Laporan lengkap tersedia di `docs/Laporan-Praktikum-Modul-6.docx` dan `docs/Laporan-Praktikum-Modul-6.pdf`. Untuk membuat ulang laporan, pasang dependensi dengan `python -m pip install -r scripts/requirements-report.txt`, lalu jalankan `.\scripts\build-practicum-report.ps1` pada Windows. Proses ini menyematkan seluruh screenshot dan mencetak PDF melalui Microsoft Edge.

## Checklist

Lihat [Checklist pengumpulan](docs/CHECKLIST.md) untuk status setiap capaian dan berkas. Bukti gambar telah disiapkan untuk relasi one-to-many, lazy loading, pivot dan cascade, relasi many-to-many, serta factory dan seeder.
