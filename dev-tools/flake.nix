{
  description = "Generic Developer Flake";

  inputs = {
    # https://flakehub.com/flake/NixOS/nixpkgs?view=usage
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nix-ai-tools.url = "github:numtide/nix-ai-tools";
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
          goverter

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

          # YAML
          yaml-language-server

          # JSON
          vscode-json-languageserver

          # Bash
          bash-language-server
          shellcheck-minimal
          shfmt
        ];
      };
    };
  };
}
