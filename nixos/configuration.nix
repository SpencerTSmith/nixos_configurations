{ config, lib, pkgs, ... }: {
  imports = [
      ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  boot.initrd.luks.devices."cryptextra".device = "/dev/disk/by-uuid/0477b0ee-296c-495d-b99b-8e6cb86d6eeb";

  boot.loader.timeout = 0;
  boot.loader.systemd-boot = {
    enable = true;
    consoleMode = "max";
    configurationLimit = 5;
  };
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_zen;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 15d";
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    git
    p7zip
    parted
  ];

  networking.hostName = "JOYOUS-MACHINE-EXCELLENCE";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Chicago";

  hardware.graphics.enable = true;
  hardware.bluetooth.enable = true;

  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    powerManagement = {
      enable = false;
      finegrained = false;
    };
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  services.openssh.enable = true;
  services.blueman.enable = true;

  services.btrfs.autoScrub = {
    enable = true;
    fileSystems = [ "/" ];
    interval = "monthly";
  };

  services.pipewire = {
    enable = true;
    pulse.enable      = true;
    alsa.enable       = true;
    alsa.support32Bit = true;
    jack.enable       = true;
  };

  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings = {
        main = {
          capslock = "overload(control, esc)";
        };
      };
    };
  };

  i18n.defaultLocale = "en_US.UTF-8";

  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];
  programs.zsh.enable = true;

  services.libinput.enable = true;

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };
  security.pam.services.hyprlock = {};

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  users.users.wayfarer = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
      shell = pkgs.zsh;
  };

# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
# Copy the NixOS configuration file and link it from the resulting system
# (/run/current-system/configuration.nix). This is useful in case you
# accidentally delete configuration.nix.
# system.copySystemConfiguration = true;

# This option defines the first version of NixOS you have installed on this particular machine,
# and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
#
# Most users should NEVER change this value after the initial install, for any reason,
# even if you've upgraded your system to a new NixOS release.
#
# This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
# so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
# to actually do that.
#
# This value being lower than the current NixOS release does NOT mean your system is
# out of date, out of support, or vulnerable.
#
# Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
# and migrated your data accordingly.
#
# For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?
}

