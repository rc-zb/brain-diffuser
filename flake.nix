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
      nixpkgs = pkgs.mkShell {
        name = "brain-diffuser";
        packages = with pkgs; [
          (python3.withPackages (ps: with ps; [
            easydict
            einops
            h5py
            imageio
            matplotlib
            mpi4py
            nibabel
            numpy
            pillow
            pyyaml
            scikit-image
            scipy
            tensorboard
            tensorboardx
            torch
            torchmetrics
            torchvision
            tqdm
            transformers
            omegaconf
            opencv4
          ]))
        ];
      };
      default = flakeOutputs.devShells.${system}.nixpkgs;
    };
  };
}
