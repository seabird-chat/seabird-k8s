{
  lib,
  stdenv,
  system,
  fetchurl,
}:
let
  version = "1.32.2";
  sources = {
    x86_64-linux = {
      url = "https://dl.k8s.io/release/v${version}/bin/linux/amd64/kubectl";
      hash = lib.fakeHash;
    };
    aarch64-darwin = {
      url = "https://dl.k8s.io/release/v${version}/bin/darwin/arm64/kubectl";
      hash = "sha256-MbYxjeqnIBS3ISHhx6LhJJbQd87km77alCUK7EyXj/s=";
    };
  };
in
stdenv.mkDerivation {
  inherit version;
  pname = "flux-bin";
  src = fetchurl sources.${system};
  dontUnpack = true;

  # Work around "unpacker appears to have produced no directories"
  sourceRoot = ".";

  installPhase = ''
    install -m755 -D $src $out/bin/kubectl
  '';
}
