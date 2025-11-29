chcp 65001
@echo off
echo %DATE%
set rnd=%RANDOM%

set godot_exe="D:\Файлы\Desktop\Помойка\Godot_v4.4.1-stable_win64.exe\Godot_v4.5.1-stable_win64.exe"

mkdir "../_zr_builds/%DATE%-%rnd%/"
mkdir "../_zr_builds/%DATE%-%rnd%/windows"
mkdir "../_zr_builds/%DATE%-%rnd%/linux"
mkdir "../_zr_builds/%DATE%-%rnd%/linux-arm64"

echo %godot_exe%

%godot_exe% --headless --export-release "Windows Desktop" "../_zr_builds/%DATE%-%rnd%/windows/zurvivalremastered.exe"
%godot_exe% --headless --export-release "Linux (x86_64)" "../_zr_builds/%DATE%-%rnd%/linux/zurvivalremastered"
%godot_exe% --headless --export-release "Linux (arm)" "../_zr_builds/%DATE%-%rnd%/linux-arm64/zurvivalremastered"

echo Файлы скомпилированны в папку ../_zr_builds/%DATE%-%rnd%/
pause