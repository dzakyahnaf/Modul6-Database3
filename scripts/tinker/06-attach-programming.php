<?php

use App\Models\Kategori;
use App\Models\Pekerjaan;

$kerja = Pekerjaan::first();
$kategori = Kategori::factory()->create([
    'name' => 'programming',
]);

$kerja->daftar_kategori()->attach($kategori->id);

dump($kerja->fresh()->daftar_kategori->pluck('name'));
$waktuTautan = $kerja->daftar_kategori()
    ->where('kategori_id', $kategori->id)
    ->first()
    ->pivot
    ->created_at
    ->toDateTimeString();

dump(['pivot created_at' => $waktuTautan]);
