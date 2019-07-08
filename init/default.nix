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
  :ci
  {:target :karma
   :output-to "target/ci.js"
   :ns-regexp ".*"}

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

  karma-conf = ''
module.exports = function (config) {
    config.set({
        browsers: ["ChromeHeadless"],
        // The directory where the output file lives
        basePath: "target",
        // The file itself
        files: ["ci.js"],
        frameworks: ["cljs-test"],
        plugins: ["karma-cljs-test", "karma-chrome-launcher"],
        colors: true,
        logLevel: config.LOG_INFO,
        client: {
            args: ["shadow.test.karma.init"],
            singleRun: true
        }
    })
};
'';

  circle-ci = ''
version: 2

jobs:
 build:
  environment:
   NIX_PATH: nixpkgs=https://github.com/NixOS/nixpkgs-channels/tarball/${pkgs.rev}
  docker:
   - image: nixorg/nix:circleci
  steps:
   - checkout
   - run: nix-shell --run 'nsc-test'
'';

  # simple npx wrapper to avoid global install
  script = pkgs.writeShellScriptBin name ''
  set -euxo pipefail
  npm init -y
  npm install --save \
   shadow-cljs@2.8.40 \
   local-web-server@3.0.4 \
   karma@4.1.0 \
   karma-firefox-launcher@1.1.0 \
   karma-cljs-test@0.1.0
  echo '${deps-edn}' > ./deps.edn
  echo '${shadow-cljs-edn}' > ./shadow-cljs.edn
  echo '${gitignore}' > ./.gitignore
  mkdir -p public
  echo '${index-html}' > ./public/index.html
  echo '${karma-conf}' > ./karma.conf.js
  mkdir -p .circleci
  echo '${circle-ci}' > ./.circleci/config.yml
  '';

in
{
 buildInputs = [
  script
 ];
}
