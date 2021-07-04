# WIP: Onivim
{ lib, fetchFromGitHub, ocamlPackages }:

with {
  inherit (ocamlPackages) buildDunePackage ppx_optcomp dune-configurator reason-sdl2;
};

buildDunePackage rec {
  pname = "Oni2";
  version =  "0.5.6";

  src = fetchFromGitHub {
    owner = "onivim";
    repo = "oni2";
    rev = "v${version}";
    sha256 = "0f1ygfli2alpsxcbn1655x86ihifqnrbkjn02gf7qayj402i6ril";
  };

  useDune2 = true;

  buildInputs = [
    ppx_optcomp
    dune-configurator
    reason-sdl2 # To-be-ported:
  ];

  meta = with lib; {
    description = "Native, lightweight modal code editor";
    downloadPage = "https://github.com/onivim/oni2";
    homepage = "https://onivim.io/";
    license = "https://github.com/onivim/oni2/blob/master/Outrun-Labs-EULA-v1.1.md"; # To-be-resolved.
    maintainers = with maintainers; [ superherointj ];
  };
}
