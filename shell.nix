{ pkgs ? import <nixpkgs> {} }:

let
  nvim-config = pkgs.stdenv.mkDerivation {
    name = "nvim-config";
    src = ./.;
    installPhase = ''
      mkdir -p $out
      cp -r ./* $out/
    '';
  };
in
pkgs.mkShell {
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
    export PS1="\n\[\033[36m\]\t \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[35m\] (nvim)\[\033[00m\] $ "

    mkdir -p ~/.config/nvim
    rsync -av --delete ${nvim-config}/ ~/.config/nvim/
    echo "Neovim configuration has been pushed to ~/.config/nvim"
  '';
}

