# crun: container runtime. Better than runc.
# ghg_cd https://github.com/containers/crun.git \
# 	&& ./autogen.sh \
# 	&& configure_install


# slirp4netns: required for many rootless container setups and Flatpak
# ghg_cd https://github.com/rootless-containers/slirp4netns \
# 	&& ./autogen.sh \
# 	&& configure_install
    

# ghg_cd https://github.com/mpv-player/mpv-build.git \
# 	&& /bin/printf '--arch=x86_64\n--enable-version3\n--enable-bzlib\n--disable-crystalhd\n--enable-fontconfig\n--enable-frei0r\n--enable-gcrypt\n--enable-gnutls\n--enable-ladspa\n--enable-libaom\n--enable-libdav1d\n--enable-libass\n--disable-libcdio\n--enable-libdrm\n--enable-libjack\n--enable-libfreetype\n--enable-libfribidi\n--enable-libgsm\n--enable-libmp3lame\n--enable-nvenc\n--enable-openal\n--enable-opencl\n--enable-opengl\n--enable-libopenjpeg\n--enable-libopus\n--enable-libpulse\n--enable-librsvg\n--enable-libsoxr\n--enable-libspeex\n--enable-libssh\n--enable-libtheora\n--enable-libvorbis\n--enable-libv4l2\n--enable-libvidstab\n--enable-libvmaf\n--enable-libvpx\n--enable-libwebp\n--enable-libx264\n--enable-libx265\n--enable-libxvid\n--enable-libzimg\n--enable-libzvbi\n--enable-avfilter\n--disable-avresample\n--enable-postproc\n--enable-pthreads\n--enable-gpl\n--disable-debug\n--enable-libmfx\n--enable-runtime-cpudetect\n--disable-vdpau' >ffmpeg_options \
# 	&& /bin/printf "--prefix=$PREFIX\n--datarootdir=$CONFIGPREFIX\n--mandir=$MANPREFIX\n--confdir=$CONFIGPREFIX\n--lua=luajit\n--disable-android\n--disable-audiounit\n--disable-caca\n--disable-cdda\n--disable-cocoa\n--disable-coreaudio\n--disable-cuda-hwaccel\n--disable-cuda-interop\n--disable-d3d-hwaccel\n--disable-d3d11\n--disable-d3d9-hwaccel\n--disable-debug-build\n--disable-direct3d\n--disable-dvdnav\n--disable-egl-android\n--disable-egl-angle\n--disable-egl-angle-lib\n--disable-egl-angle-win32\n--disable-egl-x11\n--disable-gl-cocoa\n--disable-gl-dxinterop\n--disable-gl-dxinterop-d3d9\n--disable-gl-win32\n--disable-gl-x11\n--disable-ios-gl\n--disable-libbluray\n--disable-macos-10-11-features\n--disable-macos-10-12-2-features\n--disable-macos-10-14-features\n--disable-macos-cocoa-cb\n--disable-macos-media-player\n--disable-macos-touchbar\n--disable-rpi\n--disable-rpi-mmal\n--disable-sdl2\n--disable-swift\n--disable-tvos\n--disable-vaapi-x-egl\n--disable-vaapi-x11\n--disable-vdpau\n--disable-videotoolbox-gl\n--disable-wasapi\n--disable-win32-internal-pthreads\n--disable-x11\n--disable-xv\n--enable-gl-wayland\n--enable-libarchive\n--enable-libmpv-shared\n--enable-vaapi-wayland\n--enable-wayland\n--enable-wayland-protocols\n--enable-wayland-scanner\n--enable-shaderc\n--enable-vulkan" >mpv_options \
# 	&& dash ./use-ffmpeg-release && dash ./use-mpv-master && dash ./use-libass-master \
# 	&& dash ./update && dash ./clean \
# 	&& dash ./scripts/libass-config && dash ./scripts/libass-build \
# 	&& cp "$LIBPREFIX/libpixman-1.a" ./build_libs/ \
# 	&& dash ./scripts/ffmpeg-config && dash ./scripts/ffmpeg-build \
# 	&& install -m 0755 ffmpeg_build/ffmpeg "$BINPREFIX" \
# 	&& install -m 0755 ffmpeg_build/ffplay "$BINPREFIX" \
# 	&& install -m 0755 ffmpeg_build/ffprobe "$BINPREFIX" \
# 	&& export CFLAGS="$CFLAGS_LTO" \
# 		LDFLAGS="$CFLAGS_LTO" \
# 		CXXFLAGS="$CFLAGS_LTO" \
# 		CPPFLAGS="$CFLAGS_LTO"


# ghg_cd https://github.com/facebook/zstd.git \
# 	&& cd build/meson \
# 	&& meson setup \
# 		--prefix "$PREFIX" \
# 		--libdir "$PREFIX/lib" \
# 		--buildtype release \
# 		--optimization 3 \
# 		-Dbin_programs=true \
# 		-Dbin_contrib=true \
# 		--default-library=static \
# 		builddir \
# 	&& ninja -C builddir && ninja -C builddir install