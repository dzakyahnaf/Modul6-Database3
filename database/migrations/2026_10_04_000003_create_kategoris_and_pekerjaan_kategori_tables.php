<?php

use App\Models\Kategori;
use App\Models\Pekerjaan;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('kategoris', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->timestamps();
        });

        Schema::create('pekerjaan_kategori', function (Blueprint $table) {
            $table->id();
            $table->foreignIdFor(Pekerjaan::class)
                ->constrained('pekerjaan')
                ->cascadeOnDelete();
            $table->foreignIdFor(Kategori::class)
                ->constrained()
                ->cascadeOnDelete();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('pekerjaan_kategori');
        Schema::dropIfExists('kategoris');
    }
};
