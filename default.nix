let
 pkgs = import ./nixpkgs;

 clojure = pkgs.callPackage ./clojure { pkgs = pkgs; };
 flush = pkgs.callPackage ./flush { pkgs = pkgs; };
 init = pkgs.callPackage ./init { pkgs = pkgs; };
 karma = pkgs.callPackage ./karma { pkgs = pkgs; };
 node = pkgs.callPackage ./node { pkgs = pkgs; };
 serve = pkgs.callPackage ./serve { pkgs = pkgs; };
 shadow-cljs = pkgs.callPackage ./shadow-cljs { pkgs = pkgs; };
 test = pkgs.callPackage ./test { pkgs = pkgs; };

 shadow-cljs-shell = pkgs.callPackage ./nix-shell {
  pkgs = pkgs;
  clojure = clojure;
  init = init;
  karma = karma;
  flush = flush;
  node = node;
  serve = serve;
  shadow-cljs = shadow-cljs;
  test = test;
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
