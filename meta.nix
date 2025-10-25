{ lib }:

{
  description = "Rhythm is just a *click* away (AppImage version for score submission and multiplayer, and binary distribution for Darwin systems)";
  homepage = "https://osu.ppy.sh";
  license = with lib.licenses; [
    mit
    cc-by-nc-40
    unfreeRedistributable # osu-framework contains libbass.so in repository
  ];
  sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
  maintainers = with lib.maintainers; [
    gepbird
    stepbrobd
    Guanran928
  ];
  mainProgram = "osu!";
  platforms = [
    "aarch64-darwin"
    "x86_64-darwin"
    "x86_64-linux"
  ];
}
