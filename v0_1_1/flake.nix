{
  description = ''Makes doing changelogs easier'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-changer-v0_1_1.flake = false;
  inputs.src-changer-v0_1_1.owner = "iffy";
  inputs.src-changer-v0_1_1.ref   = "v0_1_1";
  inputs.src-changer-v0_1_1.repo  = "changer";
  inputs.src-changer-v0_1_1.type  = "github";
  
  inputs."argparse".owner = "nim-nix-pkgs";
  inputs."argparse".ref   = "master";
  inputs."argparse".repo  = "argparse";
  inputs."argparse".dir   = "v3_0_0";
  inputs."argparse".type  = "github";
  inputs."argparse".inputs.nixpkgs.follows = "nixpkgs";
  inputs."argparse".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-changer-v0_1_1"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-changer-v0_1_1";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}