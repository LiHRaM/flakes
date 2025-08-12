{
  description = "skhd.zig - A simple hotkey daemon for macOS, written in Zig";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in
    {
      packages = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          
          # Determine the correct binary based on system architecture
          binaryInfo = if system == "aarch64-darwin" then {
            url = "https://github.com/jackielii/skhd.zig/releases/download/v0.0.12/skhd-arm64-macos.tar.gz";
            sha256 = "c7def2a06d4f4ef28f7db0ef08c449dc35bfa9f4abc355c327b64226855adc34";
            binaryName = "skhd-arm64-macos";
          } else if system == "x86_64-darwin" then {
            url = "https://github.com/jackielii/skhd.zig/releases/download/v0.0.12/skhd-x86_64-macos.tar.gz";
            sha256 = "f09f92b64e4b0e89ce51beb9b63fd4608c5befb740f325f7187fefd43d46ef70";
            binaryName = "skhd-x86_64-macos";
          } else throw "Unsupported system: ${system}";
        in
        {
          skhd = pkgs.stdenv.mkDerivation {
            pname = "skhd-zig";
            version = "0.0.12";

            src = pkgs.fetchurl {
              url = binaryInfo.url;
              sha256 = binaryInfo.sha256;
            };

            sourceRoot = ".";
            
            nativeBuildInputs = [ pkgs.gnutar ];

            installPhase = ''
              runHook preInstall
              
              mkdir -p $out/bin
              cp ${binaryInfo.binaryName} $out/bin/skhd
              chmod +x $out/bin/skhd
              
              runHook postInstall
            '';

            meta = with pkgs.lib; {
              description = "Simple hotkey daemon for macOS, written in Zig";
              homepage = "https://github.com/jackielii/skhd.zig";
              license = licenses.mit;
              platforms = platforms.darwin;
              maintainers = [ ];
            };
          };

          default = self.packages.${system}.skhd;
        });

      apps = forAllSystems (system: {
        skhd = {
          type = "app";
          program = "${self.packages.${system}.skhd}/bin/skhd";
        };
        default = self.apps.${system}.skhd;
      });
    };
}
