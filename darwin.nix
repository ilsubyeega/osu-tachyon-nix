{
  stdenvNoCC,
  makeWrapper,
  pname,
  version,
  src,
  meta,
  passthru,
}:

stdenvNoCC.mkDerivation {
  inherit
    pname
    version
    src
    meta
    passthru
    ;

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    runHook preInstall
    OSU_WRAPPER="$out/Applications/osu!.app/Contents"
    OSU_CONTENTS="osu!.app/Contents"
    mkdir -p "$OSU_WRAPPER/MacOS"
    cp -r "$OSU_CONTENTS/Info.plist" "$OSU_CONTENTS/Resources" "$OSU_WRAPPER"
    cp -r "osu!.app" "$OSU_WRAPPER/Resources/osu-wrapped.app"
    makeWrapper "$OSU_WRAPPER/Resources/osu-wrapped.app/Contents/MacOS/osu!" "$OSU_WRAPPER/MacOS/osu!" --set OSU_EXTERNAL_UPDATE_PROVIDER 1
    runHook postInstall
  '';
}
