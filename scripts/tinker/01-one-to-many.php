<?php

use App\Models\Pekerjaan;
use App\Models\Perusahaan;

$kerja = Pekerjaan::first();
dump($kerja->only(['id', 'title', 'perusahaan_id']));
dump($kerja->perusahaan->only(['id', 'nama']));
dump($kerja->perusahaan->nama);

$perusahaan = Perusahaan::first();
dump($perusahaan->pekerjaan->pluck('title'));
