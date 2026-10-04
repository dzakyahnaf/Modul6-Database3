<?php

use App\Models\Pekerjaan;
use Illuminate\Support\Facades\DB;

DB::enableQueryLog();

$kerja = Pekerjaan::first();
$kerja->perusahaan;
$namaPerusahaan = $kerja->perusahaan->nama;

dump($namaPerusahaan);
dump(DB::getQueryLog());
dump(count(DB::getQueryLog()));
