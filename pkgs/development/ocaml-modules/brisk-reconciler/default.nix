{ lib, fetchFromGitHub, buildDunePackage, reason, reason-native, ppxlib, ppx_deriving, ocamlPackages }:

buildDunePackage {
  pname = "brisk-reconciler";
  version = "20201202";

  src = fetchFromGitHub {
    owner = "briskml";
    repo = "brisk-reconciler";
    rev = "c9d5c4cf5dd17ff2da994de2c3b0f34c72778f70";
    sha256 = "sha256-AAB4ZzBnwfwFXOAqX/sIT6imOl70F0YNMt96SWOOE9w=";
  };

  useDune2 = true;

  buildInputs = [
    reason
    ppxlib
    ppx_deriving
  ];

  checkInputs = [
    #ocamlPackages.junit # <- Not sure about this dependency.
    reason-native.rely
    reason-native.rely-junit-reporter
  ];
  #doCheck = true; # Errors as:
    # The constructor JUnit does not belong to type Rely.RunConfig.reporter

  meta = with lib; {
    description = "An easy way to model any tree-shaped state with simple stateful functions";
    downloadPage = "https://github.com/briskml/brisk-reconciler";
    license = licenses.mit;
    maintainers = with maintainers; [ superherointj ];
  };
}
