{ pkgs }:
let

  name = "nsc-test";

  # simple npx wrapper to avoid global install
  script = pkgs.writeShellScriptBin name ''
  set -euxo pipefail
  shadow-cljs compile ci
  karma start --single-run --browsers FirefoxHeadless
  '';

in
{
 buildInputs = [
  script
 ]
 # BYO firefox on mac!
 # https://github.com/NixOS/nixpkgs/issues/53979
 ++ pkgs.lib.optionals (! pkgs.stdenv.isDarwin) [ pkgs.firefox ]
 ;
}
