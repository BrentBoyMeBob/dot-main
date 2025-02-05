{ ... }:

{
  homebrew = {
    enable = true;

    taps = [
      "smudge/smudge"
    ];
    brews = [
      "cocoapods"
      "xcodes"
      "nightlight"

      # TODO: remove these when p2pool on nix is fixed
      "monero"
      "libuv" "zmq" "libpgm"  # p2pool dependencies
      "xmrig"

      "kanata"
      "podman" "podman-compose"
      "qemu"
      "wireguard-tools"
    ];
    casks = [
      "librewolf"
      "raycast"
      "wezterm" "ghostty" # TODO: which way, western bingus
      "hammerspoon"

      "element"

      "android-studio"
      "obs"
      "ollama"
      "utm"

      "iina"
      "skim"
      "openscad@snapshot"
      "steam"

      "ultimaker-cura"
      "orcaslicer"

      "coconutbattery"
    ];
  };
}
