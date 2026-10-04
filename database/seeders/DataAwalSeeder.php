<?php

namespace Database\Seeders;

use App\Models\Pekerjaan;
use App\Models\Perusahaan;
use Illuminate\Database\Seeder;

class DataAwalSeeder extends Seeder
{
    public function run(): void
    {
        $perusahaan = [
            Perusahaan::create([
                'nama' => 'PT Nusa Teknologi',
                'alamat' => 'Jakarta',
            ]),
            Perusahaan::create([
                'nama' => 'CV Karya Digital',
                'alamat' => 'Bandung',
            ]),
            Perusahaan::create([
                'nama' => 'PT Arunika Data',
                'alamat' => 'Yogyakarta',
            ]),
        ];

        Pekerjaan::insert([
            [
                'perusahaan_id' => $perusahaan[0]->id,
                'title' => 'Software Engineer',
                'deskripsi' => 'Membangun aplikasi web.',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'perusahaan_id' => $perusahaan[0]->id,
                'title' => 'Data Analyst',
                'deskripsi' => 'Menganalisis data produk.',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'perusahaan_id' => $perusahaan[1]->id,
                'title' => 'QA Engineer',
                'deskripsi' => 'Menjaga kualitas aplikasi.',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'perusahaan_id' => $perusahaan[2]->id,
                'title' => 'Database Administrator',
                'deskripsi' => 'Merawat basis data.',
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);
    }
}
