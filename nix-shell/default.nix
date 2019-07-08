{ pkgs, clojure, flush, init, node, serve, shadow-cljs }:
let
in
{
 name = "nix-shadow-cljs-shell";

 buildInputs = []
 ++ clojure.buildInputs
 ++ flush.buildInputs
 ++ node.buildInputs
 ++ serve.buildInputs
 ++ shadow-cljs.buildInputs
 ;

 shellHook = ''
 npm install
 '';

}
