# Links Windows-side configs from this repo into place using junctions.
# Safe to re-run: anything that already exists is skipped, never overwritten.

$links = [ordered]@{
  "$HOME\.glzr\glazewm"         = "$PSScriptRoot\glazewm\.glzr\glazewm"
  "$HOME\.glzr\zebar"           = "$PSScriptRoot\zebar\.glzr\zebar"
  "$HOME\.config\tacky-borders" = "$PSScriptRoot\tacky-borders\.config\tacky-borders"
}

foreach ($l in $links.GetEnumerator()) {
  if (Test-Path $l.Key) { Write-Host "skip   $($l.Key) (exists)"; continue }
  New-Item -ItemType Directory -Force (Split-Path $l.Key) | Out-Null
  New-Item -ItemType Junction -Path $l.Key -Target $l.Value | Out-Null
  Write-Host "linked $($l.Key) -> $($l.Value)"
}
