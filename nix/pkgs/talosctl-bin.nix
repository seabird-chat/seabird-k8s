{
  lib,
  stdenv,
  fetchurl,
  system,
}:
let
  version = "1.9.5";
  sources = {
    x86_64-linux = {
      url = "https://github.com/siderolabs/talos/releases/download/v${version}/talosctl-linux-amd64";
      hash = lib.fakeHash;
    };
    aarch64-darwin = {
      url = "https://github.com/siderolabs/talos/releases/download/v${version}/talosctl-darwin-arm64";
      hash = "sha256-HlqeOTzkWWbM/D90X9XSyOP10/jfKicU478YDoKQZho=";
    };
  };
in
stdenv.mkDerivation {
  pname = "talosctl-bin";
  version = version;
  src = fetchurl sources.${system};
  dontUnpack = true;
  installPhase = ''
    install -m755 -D $src $out/bin/talosctl
  '';
}
