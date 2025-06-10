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
          nushell
          helix
          yazi
          watchexec
          jujutsu
          fd
          go-task
          carapace
          difftastic
          starship
          television
          
          # Golang
          go
          gopls
          buf
          protobuf_29
          protoc-gen-go
          protoc-gen-go-grpc
          mockgen

          # Rust
          cargo
          rustc

          # Python
          uv
          
          # Just
          just
          just-lsp

          # Markdown
          markdown-oxide
          marksman

          # NodeJS
          yarn

          # TypeScript
          typescript-language-server

          # Nix
          nil

          # Unison
          unison-ucm

          # Kubernetes
          k9s
          kubectl
          kubectx

        ];
      };
    };
  };
}
