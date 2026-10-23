{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";
  };

  outputs = { self, nixpkgs }: {
    devShells = builtins.mapAttrs 
    (system: _: 
      let
        pkgs = import nixpkgs { 
          inherit system;
          config.allowUnfree = true;
        };
      in
      {
        default = pkgs.mkShell {
          packages = with pkgs; [
            nodejs
          ];
        };
      }) nixpkgs.legacyPackages;
  };
}
