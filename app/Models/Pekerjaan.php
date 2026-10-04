<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

class Pekerjaan extends Model
{
    use HasFactory;

    protected $table = 'pekerjaan';

    protected $fillable = [
        'perusahaan_id',
        'title',
        'deskripsi',
    ];

    public function perusahaan(): BelongsTo
    {
        return $this->belongsTo(Perusahaan::class);
    }

    public function daftar_kategori(): BelongsToMany
    {
        return $this->belongsToMany(Kategori::class, 'pekerjaan_kategori')
            ->withTimestamps();
    }
}
