{
  writeShellApplication,
  tmux,
  pywal,
}:

writeShellApplication {
  name = "tmux-code";
  runtimeInputs = [
    tmux
    pywal
  ];
  text = builtins.readFile ../scripts/tmux-code.sh;
}
