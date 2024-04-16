{
  description = "Brain-Diffuser";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };
  outputs = { ... } @ flakeInputs: let
    flakeOutputs = flakeInputs.self.outputs;
    system = "x86_64-linux";
    pkgs = flakeInputs.nixpkgs.legacyPackages.${system};
  in {
    devShells.${system} = {
      python3 = pkgs.mkShell {
        name = "brain-diffuser";
        packages = with pkgs; [
          (python3.withPackages (ps: with ps; [
            h5py
            imageio
            nibabel
            numpy
            scikit-image
            scipy
            torch
          ]))
        ];
      };
      default = flakeOutputs.devShells.${system}.python3;
    };
  };
}
