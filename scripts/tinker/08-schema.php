<?php

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

DB::statement('PRAGMA foreign_keys = ON');

dump(['foreign keys aktif' => DB::select('PRAGMA foreign_keys')]);
dump(['kolom pivot' => Schema::getColumnListing('pekerjaan_kategori')]);
dump(['foreign key pivot' => DB::select('PRAGMA foreign_key_list(pekerjaan_kategori)')]);
