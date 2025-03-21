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
            tmux
          ];
          shellHook = ''

            echo Sourcing Shell Prompt
            function parse_git_dirty {
              [[ $(git status --porcelain 2>/dev/null) ]] && echo "*"
            }
            function parse_git_branch {
              git branch --no-color 2>/dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ (\1$(parse_git_dirty))/"
            }

# https://code.mendhak.com/simple-bash-prompt-for-developers-ps1-git/
            # contains shell level
            # export PS1="\n\[\033[36m\]\t \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[35m\] (nvim) \[\033[34m\][$SHLVL]\[\033[00m\]\n$ "
            export PS1="\n\[\033[36m\]\t \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[35m\] (nvim) \[\033[00m\]\n$ "


            mkdir -p ~/.config/nvim
            rsync -av --delete ${nvim-config}/ ~/.config/nvim/
            echo "Neovim configuration has been pushed to ~/.config/nvim"
          '';
        };
      }
    );
}
