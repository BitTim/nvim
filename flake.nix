# Modified from https://git.voidarc.co.uk/voidarc/nvim/src/branch/main/flake.nix

{
  description = "Dendritic NeoVim config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    wrappers.url = "github:BirdeeHub/nix-wrapper-modules";
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];

      # A helper function to generate outputs for each system
      # It imports nixpkgs for the system and passes the resulting 'pkgs' to the function 'f'
      forAllSystems =
        f: nixpkgs.lib.genAttrs supportedSystems (system: f (import nixpkgs { inherit system; }));
    in
    {
      # Use the helper to generate the packages attribute for every system
      packages = forAllSystems (
        pkgs:
        let
          pkgList = with pkgs; [
            # LSPs
            lua-language-server
            stylua

            # other tools
            lua5_1
            tree-sitter
            fzf
            luarocks
          ];
        in
        {
          # Define the default package for this system
          default = inputs.wrappers.wrappers.neovim.wrap {
            inherit pkgs;
            env = {
              "CONFIG_ROOT" = ./.;
              "NVIM_APPNAME" = "nvim-undefbloom";
            };
            runtimePkgs = pkgList;
            settings.config_directory = ./.;
          };
        }
      );
    };
}
