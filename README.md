# chromium-webgl-dx11-shared-texture
Render a system wide shared texture through WebGL in Chromium

## Description

This Chromium patch makes it possible to render an external Dx11 texture within WebGL2, providing high-performance texture sharing capability. It adds a new custom ANGLE extension (GL_ANGLE_shared_external_surface) to Chromium which defines its WebGL2 API (gl.texImage2DShared(uint32)) to accept Dx11 shared handles from IDXGIResource::GetSharedHandle for a GL texture.

* You may have to force Chromium to use the Dx11 ANGLE backend if it doesn't by default: --use-angle=d3d11
* Texture sharing requires the source and client graphics device to be created on the same physical device. You may have to force Chromium to run on a specific physical graphics device.

## Building

### 1. Checkout CEF + Chromium and do a full build.

### 2. Checkout the following additional dependencies for the WebGL autogen process:

> cd chromium_git\chromium\src\third_party\angle\third_party\OpenGL-Registry\src  
> git clone https://github.com/KhronosGroup/OpenGL-Registry .  
> git checkout 5bae8738b23d06968e7c3a41308568120943ae77  

> cd chromium_git\chromium\src\third_party\angle\third_party\EGL-Registry\src  
> git clone https://github.com/KhronosGroup/EGL-Registry .  
> git checkout 7dea2ed79187cd13f76183c4b9100159b9e3e071  

> cd chromium_git\chromium\src\third_party\angle\third_party\OpenCL-Docs\src  
> git clone https://github.com/KhronosGroup/OpenCL-Docs .  
> git checkout 774114e8761920b976d538d47fad8178d05984ec  

> mkdir chromium_git\chromium\src\third_party\angle\third_party\vulkan-deps\spirv-headers\src  
> cd chromium\src\third_party\angle\third_party\vulkan-deps\spirv-headers\src  
> git clone https://github.com/KhronosGroup/SPIRV-Headers .  

> mkdir chromium_git\chromium\src\third_party\angle\third_party\vulkan-deps\vulkan-headers\src  
> cd chromium_git\chromium\src\third_party\angle\third_party\vulkan-deps\vulkan-headers\src  
> git clone https://github.com/KhronosGroup/Vulkan-Headers .  

You can get the correct commits from some of these repos by reading **chromium_git\chromium\src\third_party\angle\DEPS**.

### 3. Apply the patches for the Chromium and ANGLE repositories from the command line:

> cd chromium_git\chromium\src  
> git apply gl_angle_shared_ext_chromium.patch  

> cd chromium_git\chromium\src\third_party\angle  
> git apply gl_angle_shared_ext_angle.patch  

### 4. Create a symbolic link that is required for the autogen scripts:

> cd chromium_git\chromium\src\third_party\angle  
> rmdir testing  
> mklink /d testing X:\XXXX\chromium_git\chromium\src\testing  

### 5. Execute the WebGL interface autogen scripts to update the WebGL definitions and bindings:

> cd chromium_git\chromium\src\gpu\command_buffer  
> python3 build_gles2_cmd_buffer.py  

> cd chromium\src\ui\gl  
> python3 generate_bindings.py  

> cd chromium_git\chromium\src\third_party\angle  
> python3 scripts\run_code_generation.py  

> cd chromium_git\chromium\src\third_party\angle\src\libANGLE\renderer\gl  
> python3 generate_gl_dispatch_table.py  

## Example

The following example renders an external texture to a canvas using the new interface: **test-shared-texture.html**

> Replace TEXTURE_HANDLE with your handle value.
