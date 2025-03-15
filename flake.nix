{
  description = "Neovim configuration with development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        nvim-config = pkgs.stdenv.mkDerivation {
          name = "nvim-config";
          src = self;
          installPhase = ''
            mkdir -p $out
            cp -r ./* $out/
          '';
        };
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            neovim
            gnumake
            clang
            fzf
            nodejs_23
            go
            rsync
          ];
          shellHook = ''
            mkdir -p ~/.config/nvim
            rsync -av --delete ${nvim-config}/ ~/.config/nvim/
            echo "Neovim configuration has been updated in ~/.config/nvim"
          '';
        };
      }
    );
}
