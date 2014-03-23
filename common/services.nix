{ config, pkgs, ... }:

{
  services.openssh.enable = false;
  services.printing.enable = false;

  services.acpid = {
    enable = true;
    lidEventCommands = ''
      lidClosed()  { grep -q closed /proc/acpi/button/lid/LID*/state; };
      isCharging() { grep -qiP '(?<!dis)charging' /sys/class/power_supply/BAT*/status; }
      if `lidClosed`; then isCharging || poweroff; fi
    '';
  };

  services.xserver = {
    enable = true;
    exportConfiguration = true;
    xkbOptions = "ctrl:nocaps,compose:rwin";
    windowManager.default = "none";
    desktopManager.xterm.enable = false;
    desktopManager.default = "none";
    displayManager.slim.defaultUser = "vi";
  };
}
