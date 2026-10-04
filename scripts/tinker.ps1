param(
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]] $TinkerArgs
)

$projectRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$prependFile = Join-Path $PSScriptRoot 'psysh-prepend.php'

php -d "auto_prepend_file=$prependFile" (Join-Path $projectRoot 'artisan') tinker @TinkerArgs
exit $LASTEXITCODE
