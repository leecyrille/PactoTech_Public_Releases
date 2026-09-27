# Pacto Tech Utility - local control API helpers for PowerShell (Windows).
#
# Load the functions into your session, then call them:
#
#   . .\PactoApi.ps1
#   Set-PactoMode 4p                         # no token needed
#   Get-PactoStatus                          # live modes, e.g. 2P ANALOG_FAST
#   Set-PactoParam -Id 2 -Value 0 -Save      # boot stick output = d-pad, kept after power-off
#   Watch-PactoModes { param($m) "now: $($m -join ', ')" }   # react to every mode change
#
# Set-PactoMode works whenever the Utility runs. Everything else uses the full
# API: switch on "Allow local AI agents" in App Options first.
# Docs: https://leecyrille.github.io/PactoTech_Public_Releases/control-api.html

$PactoBase = "http://127.117.73.87:47391"

function Get-PactoToken {
    $path = Join-Path $env:LOCALAPPDATA "PactoConfigurator\agent_token.txt"
    if (-not (Test-Path $path)) { throw "No token yet: start the Pacto Tech Utility once." }
    (Get-Content $path -Raw).Trim()
}

function Invoke-Pacto([string]$Method, [string]$Path, $Body = $null) {
    $p = @{ Method = $Method; Uri = "$PactoBase$Path"; TimeoutSec = 5
            Headers = @{ Authorization = "Bearer $(Get-PactoToken)" } }
    if ($null -ne $Body) {
        $p.Body = ($Body | ConvertTo-Json -Compress -Depth 8)
        $p.ContentType = "application/json"
    }
    Invoke-RestMethod @p
}

# Switch a mode (same as the front-end scripts; no token).
function Set-PactoMode([Parameter(Mandatory)][string]$Mode) {
    Invoke-RestMethod -Uri "$PactoBase/mode/$Mode" -TimeoutSec 5
}

# Everything at once: settings, board, live modes, remaps, game profiles, running game.
function Get-PactoState { Invoke-Pacto GET /agent/state }

# Just the live modes: mode_flags (number) and modes (names).
function Get-PactoStatus { (Invoke-Pacto GET /agent/status).status }

# A board parameter (ids on the docs page). -Save keeps it after power-off.
function Set-PactoParam([int]$Id, [int]$Value, [switch]$Save) {
    Invoke-Pacto POST /agent/param @{ id = $Id; value = $Value; save = [bool]$Save }
}

# Remap buttons for every player, e.g. swap A and B:
#   Set-PactoRemap @{ "12" = 13; "13" = 12 } -Save
# Undo:  Set-PactoRemap @{ "12" = 255; "13" = 255 } -Save
function Set-PactoRemap([hashtable]$Map, [int]$Profile = 0, [switch]$Save) {
    Invoke-Pacto POST /agent/remap @{ profile = $Profile; map = $Map; save = [bool]$Save }
}

# Run $OnChange with the mode names every time the live modes change.
# (The Windows Utility has no push stream yet; polling every 250 ms is cheap.)
function Watch-PactoModes([scriptblock]$OnChange, [int]$IntervalMs = 250) {
    $last = $null
    while ($true) {
        try {
            $st = Get-PactoStatus
            if ($st.mode_flags -ne $last) { $last = $st.mode_flags; & $OnChange $st.modes }
        } catch {
            if ($last -ne -1) { $last = -1; Write-Warning "Utility or controller not reachable: $($_.Exception.Message)" }
        }
        Start-Sleep -Milliseconds $IntervalMs
    }
}
