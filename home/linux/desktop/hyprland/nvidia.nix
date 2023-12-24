{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.desktop.hyprland;
in {
  options.modules.desktop.hyprland = {
    nvidia = mkEnableOption "whether nvidia GPU is used";
  };

  config = mkIf (cfg.enable && cfg.nvidia) {
    systemd.user.sessionVariables = {
      # for hyprland with nvidia gpu, ref https://wiki.hyprland.org/Nvidia/
      "LIBVA_DRIVER_NAME" = "nvidia";
      "XDG_SESSION_TYPE" = "wayland";
      "GBM_BACKEND" = "nvidia-drm";
      "__GLX_VENDOR_LIBRARY_NAME" = "nvidia";
      "WLR_NO_HARDWARE_CURSORS" = "1";
      "WLR_EGL_NO_MODIFIRES" = "1";
    };
  };
}
