
@echo off

echo Remember to run this as admin.

rem you can find the correct hash for your version of chromium in third_party/angle/DEPS

set chromiumSourceDir=D:\dev\cef_7680\chromium_git\chromium\src

cd /d %chromiumSourceDir%\third_party\angle\third_party\OpenGL-Registry\src
IF NOT EXIST ".git" call git clone https://github.com/KhronosGroup/OpenGL-Registry .
call git checkout d38ff693f3e99ac5a61e3858de76c6c02976fa67

cd %chromiumSourceDir%\third_party\angle\third_party\EGL-Registry\src
IF NOT EXIST ".git" call git clone https://github.com/KhronosGroup/EGL-Registry .
call git checkout 7dea2ed79187cd13f76183c4b9100159b9e3e071

cd %chromiumSourceDir%\third_party\angle\third_party\OpenCL-Docs\src
IF NOT EXIST ".git" call git clone https://github.com/KhronosGroup/OpenCL-Docs .
call git checkout 5b4ca15f0e5a5be87b56b99f652f728e05cab587

mkdir %chromiumSourceDir%\third_party\angle\third_party\spirv-headers\src
cd %chromiumSourceDir%\third_party\angle\third_party\spirv-headers\src
IF NOT EXIST ".git" call git clone https://github.com/KhronosGroup/SPIRV-Headers .
call git checkout f31ca173eff866369e54d35e53375fadbabd58f4

mkdir %chromiumSourceDir%\third_party\angle\third_party\vulkan-headers\src
cd %chromiumSourceDir%\third_party\angle\third_party\vulkan-headers\src
IF NOT EXIST ".git" call git clone https://github.com/KhronosGroup/Vulkan-Headers .
call git checkout 49f1a381e2aec33ef32adf4a377b5a39ec016ec4

cd %chromiumSourceDir%\third_party\angle
rmdir testing

rem MKLINK NEEDS ADMIN
mklink /d testing %chromiumSourceDir%\testing

pause
