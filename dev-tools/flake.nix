{
  description = "CLI and Kubernetes Developer Tools";

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
          nushell
          helix
          yazi
          watchexec
          fd
          go-task
          carapace
          difftastic
          starship
          television
          k9s
          kubectl
          kubectx
        ];
      };
    };
  };
}
