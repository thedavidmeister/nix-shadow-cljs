{ pkgs }:
let

  script = pkgs.writeShellScriptBin "nsc-flush" ''
  set -euxo pipefail
  rm -f ./package-lock.json
  rm -rf ./.npm
  rm -rf ./.shadow-cljs
  rm -rf ./node_modules
  rm -rf ~/node_modules
  rm -rf ./public/js
  '';

in
{
 buildInputs = [
  script
 ];
}
