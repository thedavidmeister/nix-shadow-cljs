{ pkgs }:
let

  name = "nsc-init";

  deps-edn = ''
{
 :deps
 {
  org.clojure/clojurescript
  {:mvn/version "1.10.520"}

  thheller/shadow-cljs
  {:mvn/version "2.8.40"}}}
'';

  shadow-cljs-edn = ''
;; shadow-cljs configuration
{
 :deps true
 :builds
 {
  :test
  {:target :karma
   :output-to "target/ci.js"
   :ns-regexp ".*"}}}

  :index
  {:target :browser
   :output-dir "public/js/index"
   :asset-path "/public/js/index"
   :modules
   {:main
    {:entries [index.mount]}}}}}
'';

  gitignore = ''
node_modules/
.npm
public/js

/target
/checkouts
/src/gen

pom.xml
pom.xml.asc
*.iml
*.jar
*.log
.shadow-cljs
.idea
.lein-*
.nrepl-*
.DS_Store

.hgignore
.hg/
.cpcache
'';

  index-html = ''
<!DOCTYPE html>
<html>
 <head>
   <script src="/public/js/index/main.js"></script>
 </head>
</html>
'';

  # simple npx wrapper to avoid global install
  script = pkgs.writeShellScriptBin name ''
  set -euxo pipefail
  npm init -y
  npm install --save \
   shadow-cljs@2.8.40 \
   local-web-server@3.0.4 \
   karma@4.1.0 \
   karma-chrome-launcher@2.2.0 \
   karma-cljs-test@0.1.0
  echo '${shadow-cljs-edn}' > ./shadow-cljs.edn
  echo '${gitignore}' > ./.gitignore
  echo '${index-html}' > ./public/index.html
  '';

in
{
 buildInputs = [
  script
 ];
}
