{ pkgs, clojure, flush, init, node, serve, shadow-cljs, test }:
let
in
{
 name = "nix-shadow-cljs-shell";

 buildInputs = []
 ++ clojure.buildInputs
 ++ flush.buildInputs
 ++ init.buildInputs
 ++ node.buildInputs
 ++ serve.buildInputs
 ++ shadow-cljs.buildInputs
 ++ test.buildInputs
 ;

 shellHook = ''
 npm install
 '';

}
