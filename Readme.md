# Config for Carlo

Everything should be in the `/standard` folder

## Usage
- Run `sudo nixos-rebuild switch --flake .#carlo` to apply your system
  configuration.

### Old stuff you probably should ignore
- Run `home-manager switch --flake .#carlo@carlo-pc` to apply your home
  configuration.
  - If you don't have home-manager installed, try `nix shell nixpkgs#home-manager`.