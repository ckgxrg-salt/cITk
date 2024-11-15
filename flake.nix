{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, rust-overlay, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      overlays = [ (import rust-overlay) ];
    };
  in {
    devShells.${system}.default = pkgs.mkShell {
      name = "rust-dev";

      buildInputs = with pkgs; [
        rust-bin.stable.latest.default
        clippy
      ];
      
      shellHook = ''
        exec nu
      '';
    };
  };
}
