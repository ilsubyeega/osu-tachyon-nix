{
  lib,
  appimageTools,
  makeWrapper,
  pname,
  version,
  src,
  meta,
  passthru,
  nativeWayland,
}:

appimageTools.wrapType2 {
  inherit
    pname
    version
    src
    meta
    passthru
    ;

  extraPkgs = pkgs: with pkgs; [ icu ];

  extraInstallCommands =
    let
      contents = appimageTools.extract { inherit pname version src; };
    in
    ''
      . ${makeWrapper}/nix-support/setup-hook
      mv -v $out/bin/${pname} $out/bin/osu!

      wrapProgram $out/bin/osu! \
        ${lib.optionalString nativeWayland "--set SDL_VIDEODRIVER wayland"} \
        --set OSU_EXTERNAL_UPDATE_PROVIDER 1

      install -m 444 -D ${contents}/osu!.desktop -t $out/share/applications
      for i in 16 32 48 64 96 128 256 512 1024; do
        install -D ${contents}/osu.png $out/share/icons/hicolor/''${i}x$i/apps/osu.png
      done
    '';
}
