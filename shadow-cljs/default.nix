{ pkgs }:
let

  script =  pkgs.writeShellScriptBin "shadow-cljs" ''
   set -euxo pipefail
   ./node_modules/.bin/shadow-cljs "$@"
   '';

in
{
 buildInputs = [
  script
 ];
}
