<?php

use App\Models\Pekerjaan;

$kerja = Pekerjaan::first();
dump($kerja->daftar_kategori->pluck('name'));

$kategori = $kerja->daftar_kategori->first();
dump($kategori->daftar_pekerjaan->pluck('title'));
