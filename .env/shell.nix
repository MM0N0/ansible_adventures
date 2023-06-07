{ pkgs ? import <nixpkgs> {} }:
  pkgs.mkShell {
    nativeBuildInputs = [ pkgs.ansible_2_13 pkgs.sshpass pkgs.python311 pkgs.python311Packages.pip pkgs.python311Packages.ansible-lint   ];
}
