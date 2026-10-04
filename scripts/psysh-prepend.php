<?php

// PsySH prefers APPDATA on Windows. Keep its history inside
// this project in restricted workspaces that cannot write to the user profile.
$_SERVER['APPDATA'] = dirname(__DIR__).'/storage/app';
