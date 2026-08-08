{
  writeShellApplication,
  inotify-tools,
  git,
}:

writeShellApplication {
  name = "notes-sync";
  runtimeInputs = [
    inotify-tools
    git
  ];
  text = builtins.readFile ../scripts/notes-sync.sh;
}
