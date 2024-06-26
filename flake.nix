{
	inputs = {
		nixpkgs.url = "nixpkgs/nixos-24.05";
		fu.url = "github:numtide/flake-utils";
		version-info-yaml = {
			type = "file";
			flake = false;
			url = "https://storage.googleapis.com/shadow-update/launcher/prod/linux/ubuntu_18.04/latest-linux.yml";
		};
	};

	outputs = { self, nixpkgs, fu, version-info-yaml }: let
		systems = [ "x86_64-linux" ];
	in fu.lib.eachSystem systems (system: let
		pkgs = import nixpkgs { inherit system; };

		readYAML = file: let
			jsonFile = pkgs.runCommand "transform" {
				buildInputs = with pkgs; [ yq jq ];
			} "yq  -j . < ${file} > $out";
		in builtins.fromJSON (builtins.readFile jsonFile);

		versionInfo = readYAML version-info-yaml;
	in {
		packages.default = pkgs.callPackage ./package.nix { inherit versionInfo; };
	});
}
