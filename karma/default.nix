{ pkgs }:
let

  script =  pkgs.writeShellScriptBin "karma" ''
   set -euxo pipefail
   ./node_modules/.bin/karma "$@"
   '';

in
{
 buildInputs = [
  script
 ];
}
