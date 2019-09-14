let
  params = {  };
  # https://vaibhavsagar.com/blog/2018/05/27/quick-easy-nixpkgs-pinning/
  inherit (import <nixpkgs> params) fetchFromGitHub;

  rev = "e9a5a28aa657bdc3170ed378693f18dfbb79fdb5";
  sha256 = "08ajj01v6jqhy9qhw5r4rp18ws77xfphdpzbsbb8461hqq48vz4p";

  # nixos holo-host channel @ 2019-04-02
  pkgs = import (fetchFromGitHub {
   owner = "NixOS";
   repo = "nixpkgs";
   rev = rev;
   sha256 = sha256;
  }) params;

in
pkgs // { rev = rev; }
