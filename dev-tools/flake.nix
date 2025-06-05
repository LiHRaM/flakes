{
  description = "Generic Developer Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{nixpkgs, flake-parts, ...}: flake-parts.lib.mkFlake {inherit inputs;} {
    systems = [
      "aarch64-darwin"
    ];

    perSystem = {pkgs, system, ...}: {
        
      packages.default = pkgs.buildEnv {
        name = "dev-utils";
        paths = with pkgs; [
          # CLI
          helix
          yazi
          watchexec
          jujutsu
          fd
          
          # Golang
          go
          gopls

          # Rust
          cargo
          rustc

          # Just
          just
          just-lsp

          # Markdown
          markdown-oxide
          marksman

          # NodeJS
          yarn

          # Nix
          nil

          # Kubernetes
          k9s
          kubectl
        ];
      };
    };
  };
}
