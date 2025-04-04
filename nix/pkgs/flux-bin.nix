{
  lib,
  stdenv,
  system,
  fetchurl,
}:
let
  version = "2.5.1";
  sources = {
    x86_64-linux = {
      url = "https://github.com/fluxcd/flux2/releases/download/v${version}/flux_${version}_linux_amd64.tar.gz";
      hash = lib.fakeHash;
    };
    aarch64-darwin = {
      url = "https://github.com/fluxcd/flux2/releases/download/v${version}/flux_${version}_darwin_arm64.tar.gz";
      hash = "sha256-aMAluAWZNEV5eNiVLAxi/QbFhdRrM0gE2nLSaOr2MNQ=";
    };
  };
in
stdenv.mkDerivation {
  inherit version;
  pname = "flux-bin";
  src = fetchurl sources.${system};

  # Work around "unpacker appears to have produced no directories"
  sourceRoot = ".";

  installPhase = ''
    install -m755 -D flux $out/bin/flux
  '';
}
