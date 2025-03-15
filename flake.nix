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
            find $out -type f -not -path '*/.git/*' -print0 | sort -z | xargs -0 sha256sum | sha256sum > $out/config.hash
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
            if [ -f ~/.config/nvim/config.hash ]; then
              cat ${nvim-config}/config.hash 
              cat ~/.config/nvim/config.hash
              if diff -q ${nvim-config}/config.hash ~/.config/nvim/config.hash >/dev/null; then
                echo "Neovim configuration is up to date"
              else
                rsync -av --delete ${nvim-config}/ ~/.config/nvim/
                echo "Neovim configuration has been updated in ~/.config/nvim"
              fi
            else
              rsync -av --delete ${nvim-config}/ ~/.config/nvim/
              echo "Neovim configuration has been initialized in ~/.config/nvim"
            fi
          '';
        };
      }
    );
}
