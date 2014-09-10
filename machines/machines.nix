{ config, pkgs, ... }:
{
  imports =
    [ ../services.nix
      ../users.nix
      ../packages.nix
      ../locale.nix
      ../security.nix
      ../network.nix
      ../nix.nix
      ../modules/client-or-server.nix
      ../modules/tor-transparent.nix
      <nixos/modules/programs/virtualbox.nix>
    ];
}
