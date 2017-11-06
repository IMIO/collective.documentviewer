{ pkgs ? import (builtins.fetchTarball  # revision for reproducible builds
  "https://github.com/nixos/nixpkgs-channels/archive/nixos-17.09.tar.gz") {}
, pythonPackages ? pkgs.python27Packages
, rubyPackages ? pkgs.rubyPackages
}:

let self = {
  buildout = pythonPackages.zc_buildout_nix.overrideDerivation(args: {
    postInstall = "";
    propagatedNativeBuildInputs = [
        pythonPackages.pillow
        pythonPackages.lxml
    ];
  });
};
  docsplit = pkgs.bundlerEnv {
     name = "docsplit";
     gemdir = ./.;
};


in pkgs.stdenv.mkDerivation rec {
  name = "env";
  # Mandatory boilerplate for buildable env
  env = pkgs.buildEnv { name = name; paths = buildInputs; };
  builder = builtins.toFile "builder.sh" ''
    source $stdenv/setup; ln -s $env $out
  '';
  # Customizable development requirements
  buildInputs = with self; [
    pkgs.bundix
    pkgs.ruby
    buildout
    pkgs.python27
    (pkgs.xpdf.override { enableGUI = false; })
    docsplit
    pkgs.libreoffice
    pkgs.graphicsmagick
  ];
  # Customizable development shell setup
  shellHook = ''
    export SSL_CERT_FILE=${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt
    export OFFICE_PATH=${pkgs.libreoffice}/bin
  '';
}
