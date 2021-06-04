{ lib, fetchFromGitHub, buildDunePackage, ocaml, findlib, cmdliner, cudf, ocaml_extlib, mccs, dune_2 }:

buildDunePackage rec {
    pname = "esy-solve-cudf";
    version = "0.1.10";

    src = fetchFromGitHub {
      owner  = "andreypopp";
      repo   = "esy-solve-cudf";
      rev    = "v${version}";
      sha256 = "sha256-pwUVSXphmISiogAagm1BQX1UMt6jge7h7cscQ/2sws8=";
      fetchSubmodules = false;
    };

    useDune2 = true;

    # buildInputs = [
    #   dune_2
    #   findlib
    #   mccs
    #   ocaml
    # ];

    propagatedBuildInputs = [
      cmdliner
      cudf
      mccs
      ocaml_extlib
    ];

    # buildPhase = ''
    #   runHook preBuild
    #   dune build -p ${pname}
    #   runHook postBuild
    # ''; #,mccs

    meta = with lib; {
      homepage = "https://github.com/andreypopp/esy-solve-cudf";
      description = "package.json workflow for native development with Reason/OCaml";
      license = licenses.gpl3;
    };
  }
