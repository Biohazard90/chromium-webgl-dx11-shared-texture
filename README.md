# chromium-webgl-dx11-shared-texture
Render a system wide shared texture through WebGL in Chromium

**Supported CEF release: 7680-146.0.7680.179**

## Description

This Chromium patch makes it possible to render an external Dx11 texture within WebGL2, providing high-performance texture sharing capability. It adds a new custom ANGLE extension (GL_ANGLE_shared_external_surface) to Chromium which defines its WebGL2 API (gl.texImage2DShared(uint32)) to accept Dx11 shared handles from IDXGIResource::GetSharedHandle for a GL texture.

* You may have to force Chromium to use the Dx11 ANGLE backend if it doesn't by default: --use-angle=d3d11
* Texture sharing requires the source and client graphics device to be created on the same physical device. You may have to force Chromium to run on a specific physical graphics device.

## Building

### 1. Checkout CEF + Chromium and do a full build.

### 2. Open third_party/angle/DEPS and find the current dependencies for the following thirdparty repositories:

> OpenGL-Registry
> EGL-Registry
> OpenCL-Docs
> spirv-headers
> vulkan-headers

Then update the script clone_angle_dev_deps.bat with the correct commit hashes and run it.

### 3. Apply the patches for the Chromium and ANGLE repositories from the command line:

> cd chromium_git\chromium\src  
> git apply gl_angle_shared_ext_chromium.patch  

> cd chromium_git\chromium\src\third_party\angle  
> git apply gl_angle_shared_ext_angle.patch  

### 4. Run generate_code.bat as admin to generate the new code required for the WebGL interface definitions and create a required symbolic link.

### 5. Rebuild CEF.

## Example

The following example renders an external texture to a canvas using the new interface: **test-shared-texture.html**

> Replace TEXTURE_HANDLE with your handle value.
