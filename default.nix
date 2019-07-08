let
 pkgs = import ./nixpkgs;

 clojure = pkgs.callPackage ./clojure { };
 flush = pkgs.callPackage ./flush { };
 init = pkgs.callPackage ./init { };
 node = pkgs.callPackage ./node { };
 serve = pkgs.callPackage ./serve { };
 shadow-cljs = pkgs.callPackage ./shadow-cljs { };

 shadow-cljs-shell = pkgs.callPackage ./nix-shell {
  pkgs = pkgs;
  clojure = clojure;
  init = init;
  flush = flush;
  node = node;
  serve = serve;
  shadow-cljs = shadow-cljs;
 };

 # functions cannot be handled by mkDerivation
 derivation-safe-shadow-cljs-shell = (removeAttrs shadow-cljs-shell ["override" "overrideDerivation"]);
in
{
 pkgs = pkgs;

 # export the set used to build shell alongside the main derivation
 # downstream devs can extend/override the shell as needed
 shell = derivation-safe-shadow-cljs-shell;
 main = pkgs.stdenv.mkDerivation derivation-safe-shadow-cljs-shell;

}
