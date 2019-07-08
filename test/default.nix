{ pkgs }:
let

  name = "nsc-test";

  # simple npx wrapper to avoid global install
  script = pkgs.writeShellScriptBin name ''
  set -euxo pipefail
  shadow-cljs compile ci
  # https://github.com/karma-runner/karma-chrome-launcher/issues/158
  karma start --single-run --browsers ChromeHeadlessNoSandbox
  '';

in
{
 buildInputs = [
  pkgs.google-chrome
  script
 ];
}
