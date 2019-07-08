{ pkgs }:
let

  # simple npx wrapper to avoid global install
  script = pkgs.writeShellScriptBin "nsc-init" ''
  set -euxo pipefail
  npm init
  npm install --save shadow-cljs@2.8.40
  npm install --save local-web-server@3.0.4
  '';

in
{
 buildInputs = [
  script
 ];
}
