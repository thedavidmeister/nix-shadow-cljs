let
  # https://vaibhavsagar.com/blog/2018/05/27/quick-easy-nixpkgs-pinning/
  inherit (import <nixpkgs> {}) fetchgit;

  # nixos holo-host channel @ 2019-04-02
  pkgs = import (fetchgit {
   url = "https://github.com/NixOS/nixpkgs.git";
   rev = "dfe72aa4e5951591b37b9f3845e27bd620d0d867";
   sha256 = "07mzi5qhrcxam2syzq2p20sngkyh48qxb3g0qgkvmyyghqdj56w9";
  }) { };

in
pkgs
