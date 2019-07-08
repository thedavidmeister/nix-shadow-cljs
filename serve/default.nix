{ pkgs }:
let

  config = import ./config.nix;

  # simple npx wrapper to avoid global install
  script = pkgs.writeShellScriptBin config.nix-command ''
  set -euxo pipefail
  # run it as an SPA
  ./node_modules/.bin/${config.npm-command} --spa ${config.index} "$@"
  '';

in
{
 buildInputs = [
  script
 ];
}
