<?php

use App\Models\Kategori;
use Illuminate\Support\Facades\DB;

DB::beginTransaction();

$kategori = Kategori::whereHas('daftar_pekerjaan')->firstOrFail();
$tautanKategori = $kategori->daftar_pekerjaan()->count();
$jumlahPivotSebelum = Kategori::all()->sum(
    fn (Kategori $item): int => $item->daftar_pekerjaan()->count()
);

$kategori->delete();

$jumlahPivotSesudah = Kategori::all()->sum(
    fn (Kategori $item): int => $item->daftar_pekerjaan()->count()
);

dump([
    'tautan kategori sebelum dihapus' => $tautanKategori,
    'seluruh pivot sebelum dihapus' => $jumlahPivotSebelum,
    'seluruh pivot sesudah dihapus' => $jumlahPivotSesudah,
]);

DB::rollBack();
