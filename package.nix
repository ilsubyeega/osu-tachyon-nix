{
  lib,
  stdenvNoCC,
  fetchurl,
  appimageTools,
  makeWrapper,
  nativeWayland ? false,
}:

let
  pname = "osu-lazer-bin-tachyon";
  
  # Load version information from JSON
  versionData = lib.importJSON ./version.json;
  version = versionData.version;

  src =
    {
      x86_64-linux = fetchurl {
        url = versionData.x86_64-linux.url;
        hash = versionData.x86_64-linux.hash;
      };
    }
    .${stdenvNoCC.system} or (throw "osu-lazer-bin: ${stdenvNoCC.system} is unsupported.");

  # Load metadata from separate module
  meta = import ./meta.nix { inherit lib; };

  passthru.updateScript = ./update.sh;
  
  # Common arguments to pass to platform-specific builders
  commonArgs = {
    inherit lib stdenvNoCC appimageTools makeWrapper;
    inherit pname version src meta passthru;
    nativeWayland = nativeWayland;
  };
in
if stdenvNoCC.hostPlatform.isDarwin then
  import ./darwin.nix commonArgs
else
  import ./linux.nix commonArgs
