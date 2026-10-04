# Laporan praktikum Modul 6

**Nama:** Herlina Dwi Septiana
Versi laporan lengkap tersedia dalam [DOCX](Laporan-Praktikum-Modul-6.docx) dan [PDF](Laporan-Praktikum-Modul-6.pdf).

## Relasi one-to-many

Model `Pekerjaan` memakai `belongsTo(Perusahaan::class)` karena foreign key `perusahaan_id` berada di tabel pekerjaan. Model `Perusahaan` memakai `hasMany(Pekerjaan::class)` karena satu perusahaan bisa mempunyai beberapa pekerjaan. Data awal berisi empat pekerjaan; dua di antaranya dimiliki PT Nusa Teknologi.

## Pengamatan lazy loading

Sejak `$kerja = Pekerjaan::first()` sampai `$kerja->perusahaan->nama`, ada **dua query**. Query pertama mengambil pekerjaan. Query kedua mengambil perusahaan saat properti relasi `perusahaan` pertama kali diakses. Eloquent menyimpan hasil relasi pada model `$kerja`, sehingga membaca `nama` sesudahnya tidak menambah query ketiga.

## Pivot table dan cascade

Tabel `pekerjaan_kategori` mempunyai kolom `id`, `pekerjaan_id`, `kategori_id`, `created_at`, dan `updated_at`. Kedua foreign key memakai `constrained()` dan `cascadeOnDelete()`. Penghapusan kategori uji menghapus tautan pivot; pemeriksaan dilakukan dalam transaksi dan di-rollback agar data demo kembali utuh.

## Factory dan seeder

`Kategori::factory()->make()` membuat objek di memori dan tidak mengubah jumlah baris. `Kategori::factory()->count(3)->create()` menyimpan tiga kategori. `KategoriSeeder` membuat lima kategori lain dan menghubungkan setiap pekerjaan ke dua kategori acak. Dengan empat pekerjaan, hasilnya **4 x 2 = 8 baris pivot** dari seeder.

Sesudah tiga kategori factory dan kategori `programming` dibuat seperti langkah Tinker di PDF, jumlah kategori menjadi **9** (5 dari seeder + 3 dari factory + 1 programming), sedangkan jumlah pivot menjadi **9** (8 dari seeder + 1 tautan programming). Tabel pivot tidak dihitung oleh factory; barisnya ditambahkan melalui `attach()`.

## Kode yang menjadi bukti

- `app/Models/Pekerjaan.php` dan `app/Models/Perusahaan.php`: relasi one-to-many.
- `app/Models/Kategori.php`: relasi many-to-many dari arah kategori.
- `database/migrations/2026_10_04_000003_create_kategoris_and_pekerjaan_kategori_tables.php`: tabel kategori, pivot, foreign key, cascade, dan urutan rollback.
- `database/factories/KategoriFactory.php`: data kategori acak.
- `database/seeders/KategoriSeeder.php`: lima kategori dan dua relasi untuk setiap pekerjaan.
