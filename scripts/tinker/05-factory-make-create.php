<?php

use App\Models\Kategori;

$sementara = Kategori::factory()->make();
dump($sementara->attributesToArray());
dump(['make tersimpan' => $sementara->exists]);

$kategoriBaru = Kategori::factory()->count(3)->create();
dump($kategoriBaru->pluck('name'));
dump(['jumlah kategori setelah create(3)' => Kategori::count()]);
