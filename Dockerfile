FROM mcr.microsoft.com/windows/servercore:ltsc2022

# Visual Studio Redistrutables needed for Vulkan
RUN curl -LO https://aka.ms/vs/17/release/vc_redist.x64.exe
RUN .\VC_redist.x64.exe /install /q /norestart

# Vulkan SDK
RUN curl -LO https://sdk.lunarg.com/sdk/download/1.3.236.0/windows/VulkanSDK-1.3.236.0-Installer.exe
RUN .\VulkanSDK-1.3.236.0-Installer.exe \
    --accept-licenses \
    --default-answer \
    --confirm-command \
    install

# Mingw64
RUN curl -LO https://github.com/niXman/mingw-builds-binaries/releases/download/12.2.0-rt_v10-rev2/x86_64-12.2.0-release-posix-seh-ucrt-rt_v10-rev2.7z
RUN curl -LO https://www.7-zip.org/a/7zr.exe
RUN 7zr x x86_64-12.2.0-release-posix-seh-ucrt-rt_v10-rev2.7z

# CMake
RUN mkdir CMake
RUN cd CMake && curl -LO https://github.com/Kitware/CMake/releases/download/v3.26.0-rc1/cmake-3.26.0-rc1-windows-x86_64.zip
RUN cd CMake && tar -xf cmake-3.26.0-rc1-windows-x86_64.zip

# Libaries
RUN mkdir dev && mkdir dev\Libraries
RUN cd dev\Libraries && curl -LO https://github.com/glfw/glfw/releases/download/3.3.8/glfw-3.3.8.bin.WIN64.zip
RUN cd dev\Libraries && tar -xf glfw-3.3.8.bin.WIN64.zip
RUN cd dev\Libraries && curl -LO https://github.com/g-truc/glm/releases/download/0.9.9.8/glm-0.9.9.8.zip
RUN cd dev\Libraries && tar -xf glm-0.9.9.8.zip

# Add cmake and mingw64 bins to Path
RUN setx /M PATH "C:\CMake\cmake-3.26.0-rc1-windows-x86_64\bin;C:\mingw64\bin;%PATH%"

COPY build.bat .
ENTRYPOINT ["cmd", "/c", "build.bat"]
