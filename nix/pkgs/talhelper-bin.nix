{
  lib,
  stdenv,
  system,
  fetchurl,
}:
let
  version = "3.0.21";
  sources = {
    x86_64-linux = {
      url = "https://github.com/budimanjojo/talhelper/releases/download/v${version}/talhelper_linux_amd64.tar.gz";
      hash = lib.fakeHash;
    };
    aarch64-darwin = {
      url = "https://github.com/budimanjojo/talhelper/releases/download/v${version}/talhelper_darwin_arm64.tar.gz";
      hash = "sha256-B6LPqFZknLlwxnLa7BqWa54bdUeFtOpWCdd3JUxg7xA=";
    };
  };
in
stdenv.mkDerivation {
  inherit version;
  pname = "talhelper-bin";
  src = fetchurl sources.${system};

  # Work around "unpacker appears to have produced no directories"
  sourceRoot = ".";

  installPhase = ''
    install -m755 -D talhelper $out/bin/talhelper
  '';
}
