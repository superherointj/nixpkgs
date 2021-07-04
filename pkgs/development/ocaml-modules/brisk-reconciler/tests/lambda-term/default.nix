{ buildDunePackage, brisk-reconciler, reason, lambdaTerm }:

buildDunePackage {
  pname = "brisk-reconciler-lambda-example";
  inherit (brisk-reconciler) src version meta;

  sourceRoot = "source/examples/lambda-term/";

  useDune2 = true;

  buildInputs = [
    reason
    brisk-reconciler
    lambdaTerm
  ];
}
