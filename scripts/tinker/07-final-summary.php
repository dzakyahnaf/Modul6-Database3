<?php

use App\Models\Kategori;
use App\Models\Pekerjaan;
use App\Models\Perusahaan;

dump([
    'perusahaan' => Perusahaan::count(),
    'pekerjaan' => Pekerjaan::count(),
    'kategori' => Kategori::count(),
    'pekerjaan_kategori' => Kategori::all()->sum(
        fn (Kategori $kategori): int => $kategori->daftar_pekerjaan()->count()
    ),
]);

$kerja = Pekerjaan::first();
dump($kerja->daftar_kategori->pluck('name'));

$kategoriTerbaru = Kategori::whereHas('daftar_pekerjaan')->latest()->first();
dump($kategoriTerbaru->daftar_pekerjaan->pluck('title'));
