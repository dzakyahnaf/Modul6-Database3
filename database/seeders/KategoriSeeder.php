<?php

namespace Database\Seeders;

use App\Models\Kategori;
use App\Models\Pekerjaan;
use Illuminate\Database\Seeder;

class KategoriSeeder extends Seeder
{
    public function run(): void
    {
        $daftarKategori = Kategori::factory()->count(5)->create();

        Pekerjaan::all()->each(function (Pekerjaan $kerja) use ($daftarKategori): void {
            $kerja->daftar_kategori()->attach(
                $daftarKategori->random(2)->pluck('id')
            );
        });
    }
}
