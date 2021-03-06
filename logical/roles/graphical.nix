{ config, lib, pkgs, ... }:

{ services.xserver = {
    enable = true;
    exportConfiguration = true;
    xkbOptions = "ctrl:nocaps,compose:rwin";
    windowManager.default = "none";
    desktopManager.xterm.enable = false;
    desktopManager.default = "none";
    displayManager.slim.defaultUser = "vi";
  };

  systemd.services."display-manager".preStart = ''
    chmod a+w $(realpath /sys/class/backlight/intel_backlight/brightness) || true
    chmod a+w $(realpath '/sys/class/leds/smc::kbd_backlight/brightness') || true
  '';

  fonts.enableFontDir = true;

  fonts.fonts = with pkgs; [
    otf-letter-gothic-mono
  ];


  environment.systemPackages = with pkgs; [
    acpid
    dzen2
    exif
    fbreader
    feh
    ffmpeg
    gitAndTools.hub
    gnome.zenity
    imagemagick
    irssi
  # mnemosyne
    mplayer
    msmtp
    mutt
    mysql
    nix
    nixops
    nmap
    offlineimap
    pdftk
    perlPackages.CryptBlowfish
    perlPackages.CryptDH
    perlPackages.CryptOpenSSLBignum
    perlPackages.MathBigInt
    pinentry
    pkgconfig
    postgresql
    proxychains
    psmisc
    python27Packages.mutagen
    redshift
    rxvt_unicode
    s3cmd_15_pre_81e3842f7a
    scrot
    slock
    surf
    texLiveFull
    unclutter
    w3m
    wpa_supplicant
    xclip
    xlibs.xev
    xlibs.xinit
    xlibs.xkbcomp
    xorg.xkill
    xorg.xwininfo
    youtubeDL
    zathura
    zlib
  ];

  security.setuidPrograms = [
    "slock"
    "pinentry"
  ];

  # sync clipboards

  systemd.user.services."autocutsel" = {
    enable = true;
    description = "Synchronise clipboards.";
    wantedBy = ["default.target"];
    reloadIfChanged = true;
    script = ''
      ${pkgs.autocutsel}/bin/autocutsel -fork
      ${pkgs.autocutsel}/bin/autocutsel -selection PRIMARY -fork
    '';
    environment = {
      DISPLAY = ":0";
    };
    serviceConfig = {
      Type = "forking";
    };
  };

  services.cron.systemCronJobs = [
    "*/5 * * * * vi /home/vi/bin/cron/dwarf"
  ];
}
