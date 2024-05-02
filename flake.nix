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
            fsspec
            gradio
            h5py
            huggingface-hub
            imageio
            matplotlib
            mpi4py
            nibabel
            numpy
            omegaconf
            open-clip-torch
            opencv4
            pillow
            pyyaml
            scikit-image
            scikit-learn
            scipy
            tensorboard
            tensorboardx
            torch
            torchmetrics
            torchvision
            tqdm
            transformers
            webdataset
          ]))
        ];
      };
      default = flakeOutputs.devShells.${system}.nixpkgs;
    };
  };
}
