{
  writeShellApplication,
  tmux,
  pywal,
}:

writeShellApplication {
  name = "tmux-float";
  runtimeInputs = [
    tmux
    pywal
  ];
  text = builtins.readFile ../scripts/tmux-float.sh;
}
