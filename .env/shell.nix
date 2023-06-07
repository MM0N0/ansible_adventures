{ pkgs ? import <nixpkgs> {} }:
  pkgs.mkShell {
    nativeBuildInputs = [ pkgs.ansible_2_13 pkgs.sshpass pkgs.ansible-lint ];
}
