# Checklist pengumpulan Modul 6

Semua delapan capaian pada lembar evaluasi PDF sudah dikerjakan. Tanda centang di bawah merujuk pada kode proyek, bukti keluaran, dan laporan praktikum yang disertakan.

## Capaian evaluasi

- [x] `belongsTo` pada `Pekerjaan` berhasil mengembalikan `Perusahaan`. Bukti: `screenshots/01-relasi-one-to-many.png`.
- [x] `hasMany` pada `Perusahaan` mengembalikan dua pekerjaan untuk perusahaan pertama. Bukti: `screenshots/01-relasi-one-to-many.png`.
- [x] Lazy loading teramati menghasilkan dua query; akses nama perusahaan memakai relasi yang sudah dimuat. Bukti: `screenshots/02-lazy-loading.png` dan penjelasan di [laporan praktikum](laporan-praktikum.md).
- [x] Pivot `pekerjaan_kategori` dibuat dengan kolom id, dua foreign key, dan timestamps. Bukti: migration `2026_10_04_000003_create_kategoris_and_pekerjaan_kategori_tables.php` dan `screenshots/03-pivot-dan-cascade.png`.
- [x] Foreign key pivot memakai `cascadeOnDelete()`; penghapusan kategori menghapus tautan pivot. Bukti: `screenshots/03-pivot-dan-cascade.png`.
- [x] `belongsToMany` dapat dibaca dari `Pekerjaan` maupun `Kategori`, dengan nama pivot eksplisit dan timestamps. Bukti: `screenshots/04-many-to-many.png`.
- [x] Factory membedakan `make()` (belum tersimpan) dan `create()` (tiga record tersimpan). Bukti: `screenshots/05-factory-dan-seeder.png`.
- [x] Seeder membuat lima kategori dan menghubungkan setiap empat pekerjaan ke dua kategori: 4 x 2 = 8 baris pivot. Bukti: `screenshots/05-factory-dan-seeder.png` dan [laporan praktikum](laporan-praktikum.md).

## Berkas pengumpulan

- [x] Kode Laravel: model, migration, factory, dan seeder tersedia di `app/` dan `database/`.
- [x] Laporan lengkap DOCX atas nama Herlina Dwi Septiana: [Laporan-Praktikum-Modul-6.docx](Laporan-Praktikum-Modul-6.docx).
- [x] Laporan lengkap PDF atas nama Herlina Dwi Septiana: [Laporan-Praktikum-Modul-6.pdf](Laporan-Praktikum-Modul-6.pdf).
- [x] Jawaban pengamatan lazy loading dan hitungan pivot dimuat dalam laporan DOCX/PDF.
- [x] Contoh perintah Tinker yang bisa diulang tersedia di `scripts/tinker/`.
- [x] Screenshot relasi one-to-many: [01-relasi-one-to-many.png](../screenshots/01-relasi-one-to-many.png).
- [x] Screenshot lazy loading: [02-lazy-loading.png](../screenshots/02-lazy-loading.png).
- [x] Screenshot pivot dan cascade: [03-pivot-dan-cascade.png](../screenshots/03-pivot-dan-cascade.png).
- [x] Screenshot belongsToMany dua arah: [04-many-to-many.png](../screenshots/04-many-to-many.png).
- [x] Screenshot factory, attach, dan jumlah seeder: [05-factory-dan-seeder.png](../screenshots/05-factory-dan-seeder.png).
- [x] Screenshot kode relasi: [06-kode-relasi.png](../screenshots/06-kode-relasi.png).
- [x] Screenshot kode migration pivot: [07-kode-migration-pivot.png](../screenshots/07-kode-migration-pivot.png).
- [x] Screenshot kode factory dan seeder kategori: [08-kode-factory-seeder.png](../screenshots/08-kode-factory-seeder.png).
- [x] Screenshot kode data awal dan DatabaseSeeder: [09-kode-database-seeder.png](../screenshots/09-kode-database-seeder.png).
- [x] Screenshot `migrate:fresh --seed` menjalankan migration dan DatabaseSeeder: [10-database-seeder-run.png](../screenshots/10-database-seeder-run.png).
- [x] Log mentah dari perintah Artisan/Tinker tersedia di `screenshots/logs/`.
- [x] Jawaban pengamatan lazy loading dan hitungan baris pivot tersedia di [laporan praktikum](laporan-praktikum.md).
- [x] Petunjuk menjalankan proyek tersedia di [README](../README.md).

## Catatan pelaksanaan

Data awal menyediakan tiga perusahaan dan empat pekerjaan. Dua pekerjaan pertama dimiliki perusahaan yang sama, sehingga relasi one-to-many dapat langsung terlihat. Pemeriksaan cascade dilakukan di dalam transaksi lalu di-rollback supaya data contoh tetap utuh. Untuk mereproduksi langkah manual pada PDF, jalankan `php artisan migrate:fresh --seed`, lalu ikuti urutan Tinker di README.
