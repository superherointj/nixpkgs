{ lib, fetchFromGitHub, buildDunePackage, ocaml, alcotest, bigarray-compat }:

buildDunePackage rec {
  pname = "bigstringaf";
  version = "0.6.1";

  useDune2 = true;

  minimumOCamlVersion = "4.03";

  src = fetchFromGitHub {
    owner = "inhabitedtype";
    repo = pname;
    rev = version;
    sha256 = "sha256-gj6lhEoHZacJLh3D5mg5z6ur2dEgmeu3+3WrxNN0h44=";
  };

  checkInputs = [ alcotest ];
  propagatedBuildInputs = [ bigarray-compat ];
  doCheck = lib.versionAtLeast ocaml.version "4.05";

  meta = {
    description = "Bigstring intrinsics and fast blits based on memcpy/memmove";
    license = lib.licenses.bsd3;
    maintainers = [ lib.maintainers.vbgl ];
    inherit (src.meta) homepage;
  };
}
