{ pkgs }:

pkgs.stdenv.mkDerivation rec {
  pname = "codex";
  version = "0.155.1";

  src = pkgs.fetchurl {
    url = "https://github.com/openai/codex/releases/download/rust-v${version}/codex-package-x86_64-unknown-linux-musl.tar.gz";
    hash = "sha256-pluJXGrBpzYpu+S4ZGQMhhM+lKQ7TWezEDBE4aMG1aI=";
  };

  sourceRoot = ".";

  nativeBuildInputs = [ pkgs.makeWrapper ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    cp -r ./* $out/

    # Make sure shipped executables are executable.
    chmod +x $out/bin/codex

    if [ -f $out/bin/codex-code-mode-host ]; then
      chmod +x $out/bin/codex-code-mode-host
    fi

    # Local MCP plugins such as codex-security require a Node runtime.
    wrapProgram $out/bin/codex \
      --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.nodejs ]}

    runHook postInstall
  '';

  meta = {
    description = "OpenAI Codex CLI";
    homepage = "https://github.com/openai/codex";
    license = pkgs.lib.licenses.asl20;
    platforms = [ "x86_64-linux" ];
    mainProgram = "codex";
  };
}
