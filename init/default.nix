{ pkgs }:
let

  name = "nsc-init";

  shadow-cljs-edn = ''
;; shadow-cljs configuration
{
 :deps true
 :builds
 {
  :index
  {:target :browser
   :output-dir "public/js/index"
   :asset-path "/public/js/index"
   :modules
   {:main
    {:entries [index.mount]}}}}}
'';

  # simple npx wrapper to avoid global install
  script = pkgs.writeShellScriptBin name ''
  set -euxo pipefail
  npm init -y
  npm install --save shadow-cljs@2.8.40
  npm install --save local-web-server@3.0.4
  echo '${shadow-cljs-edn}' > ./shadow-cljs.edn
  '';

in
{
 buildInputs = [
  script
 ];
}
