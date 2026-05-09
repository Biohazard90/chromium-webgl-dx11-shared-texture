
@echo off

set chromiumSourceDir=D:\dev\cef_7680\chromium_git\chromium\src

rem these don't need the extra khronos repositories
cd %chromiumSourceDir%\gpu\command_buffer
python3 build_gles2_cmd_buffer.py

cd %chromiumSourceDir%\ui\gl
python3 generate_bindings.py

pause