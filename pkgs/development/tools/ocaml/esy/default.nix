{ lib, fetchFromGitHub, callPackage, ocamlPackages, zip, ocamlformat, ocaml, dune_2 }:

with {
  inherit (ocamlPackages )
    angstrom
    astring
    #bigstringaf # 7.0.0 is disabled in favor of 0_6_1 version.
    bos
    buildDunePackage
    bz2
    cmdliner
    cudf
    dose3
    dune-configurator
    fmt
    fpath
    lambdaTerm
    logs
    lwt
    lwt_ppx
    mccs
    menhir
    ocamlgraph
    opam-core
    opam-file-format
    opam-format
    opam-state
    ppx_deriving
    ppx_deriving_yojson
    ppx_expect
    ppx_inline_test
    ppx_let
    ppx_sexp_conv
    re
    reason
    stdlib-shims
    yojson
    # dependencies of bigstringaf_0_6_1
    alcotest
    bigarray-compat
    # dependencies of esy-solve-cudf
    ocaml_extlib
    findlib
  ;
};

let
  bigstringaf_0_6_1 = callPackage ./bigstringaf_0_6_1.nix {
    inherit alcotest bigarray-compat buildDunePackage;
  };
  esy-solve-cudf = callPackage ./esy-solve-cudf.nix {
    inherit lib fetchFromGitHub buildDunePackage ocaml findlib cmdliner cudf ocaml_extlib mccs dune_2;
  };
in

buildDunePackage rec {
  pname = "esy";
  version = "0.6.10";

  src = fetchFromGitHub {
    owner = "esy";
    repo = "esy";
    rev = "v${version}";
    sha256 = "0ffxnzb32r4fmvpfhh7ns4djkgyhwwidgqimhxbkn7z12wygzd8r";
  };

  # `src` patched/experimental: [Ignore this.]
  # src = fetchFromGitHub {
  #   owner = "superherointj";
  #   repo = "esy";
  #   rev = "cbffe359963bbc32c1596f360981f5c3ef86c4c3";
  #   sha256 = "sha256-1OeYh4StB51bb8q6rdMNhlcNN5Qb70/uVa7SMqqnUl4=";
  # };

  useDune2 = true;
  minimalOCamlVersion = "4.12";

  buildInputs = [
    angstrom
    astring  # *resolution
    #bigstringaf # *resolution
    bigstringaf_0_6_1
    bos # *resolution
    cmdliner# *resolution
    # cudf
    dose3
    dune-configurator #* outside esy
    esy-solve-cudf
    fmt
    fpath
    lambdaTerm
    logs
    lwt # *resolution
    lwt_ppx
    mccs
    menhir
    ocamlformat
    opam-core
    opam-file-format
    opam-format
    opam-state
    ppx_deriving
    ppx_deriving_yojson
    ppx_expect
    ppx_inline_test
    ppx_let
    ppx_sexp_conv
    re
    reason
    yojson
  ];

  meta = with lib; {
    description = "Easy package management for native Reason, OCaml and more";
    downloadPage = "https://esy.sh";
    homepage = "https://github.com/esy/esy";
    license = licenses.mit;
    maintainers = with maintainers; [ superherointj ];
  };

}

# ---- Esy is using locked versions of:

# "resolutions": {
#   "@opam/astring": "github:dune-universe/astring:astring.opam#d907613e73186310aa89f13812aa974dbfc282d6",
#   "@opam/bigstringaf": "0.6.1",
#   "@opam/bos": {
#     "source": "github:esy-ocaml/bos:opam#a241814516fbe2",
#     "override": {"dependencies": {"@opam/mtime": "*"}}
#   },
#   "@opam/cmdliner": "github:esy-ocaml/cmdliner:cmdliner.opam#e9316bc",
#   "@opam/lwt": "github:ocsigen/lwt:lwt.opam#9943ba77a5508feaea5e1fb60b011db4179f9c61"
# }
