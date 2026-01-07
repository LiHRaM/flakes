{
  description = "Language Tools and LSPs";

  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{nixpkgs, flake-parts, ...}: flake-parts.lib.mkFlake {inherit inputs;} {
    systems = [
      "aarch64-darwin"
    ];

    perSystem = {pkgs, system, ...}: {
        
      packages.default = pkgs.buildEnv {
        name = "language-tools";
        paths = with pkgs; [
          # Golang
          go

          # Rust
          rustup

          # Python
          uv
          
          # Just
          just
          just-lsp

          # Markdown
          markdown-oxide
          marksman

          # TypeScript
          typescript-language-server

          # Nix
          nil

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
