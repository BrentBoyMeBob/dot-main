{ pkgs, ... }:

{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking.wireless.enable = false;
  networking.networkmanager.enable = true;

  time.timeZone = "America/Los_Angeles";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
    displayManager.gdm.enable = true;
    displayManager.defaultSession = "none+i3";
    desktopManager.gnome.enable = true;
    desktopManager.xterm.enable = false;
    windowManager.i3 = {
      enable = true;
    };
  };

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # jack.enable = true;
    # media-session.enable = true;
  };

  users.users.brent = {
    isNormalUser = true;
    description = "Brent";
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
    packages = with pkgs; []; 
  };
  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    firefox
    btop git vim wget
    koreader
    neofetch

    dunst i3lock i3status dmenu
    hsetroot rxvt-unicode xsel lxappearance scrot
    cmus ranger vim fish
  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji-blob-bin
    liberation_ttf
    geist-font
  ];

  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "yes";
  };

  # Enable on QEMU, disable on AVF.
  services.qemuGuest.enable = false;
  services.spice-vdagentd.enable = false;

  system.stateVersion = "unstable";
}
