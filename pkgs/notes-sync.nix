{
  inotifywait,
  git,
}:

writeShellApplication {
  name = "notes-sync";
  runtimeInputs = [
    inotifywait
    git
  ];
  text = builtins.readFile ../scripts/notes-sync.sh;
}
