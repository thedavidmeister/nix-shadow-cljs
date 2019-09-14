let
  params = {  };
  # https://vaibhavsagar.com/blog/2018/05/27/quick-easy-nixpkgs-pinning/
  inherit (import <nixpkgs> params) fetchFromGitHub;

  rev = "8a530a0bab1f1d28723e690f702f7a103dc6741d";
  sha256 = "16b76msp6xhhfi7hiq8xh0z2ir5lwys5rqy85l5vg81vp6xkgyc3";

  # nixos holo-host channel @ 2019-04-02
  pkgs = import (fetchFromGitHub {
   owner = "NixOS";
   repo = "nixpkgs";
   rev = rev;
   sha256 = sha256;
  }) params;

in
pkgs // { rev = rev; }
