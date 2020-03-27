{ pkgs ? import <nixpkgs> {} }:

with pkgs;

let
  inherit (lib) optional optionals;

  # elixir = beam.packages.erlangR22.elixir_1_9;

  erlang_wx = erlangR22.override {
    wxSupport = true;
  };

  elixir = (beam.packagesWith erlang_wx).elixir.override {
    version = "1.9.2";
    rev = "ffe7a577cc80f37381dc289c820842d346002364";
    sha256 = "19yn6nx6r627f5zbyc7ckgr96d6b45sgwx95n2gp2imqwqvpj8wc";
  };

  nodejs = nodejs-10_x;
  postgresql = postgresql_10;
in

mkShell {
  buildInputs = [ erlang_wx elixir nodejs yarn git postgresql ]
    ++ optionals stdenv.isLinux [ inotify-tools wxGTK ] # For file_system on Linux.
    ++ optionals stdenv.isDarwin (with darwin.apple_sdk.frameworks; [
      # For file_system on macOS.
      CoreFoundation
      CoreServices
      wxmac
    ]);

    shellHook = ''
      # export MIX_ENV=dev
      # export PGDATA="$PWD/db"
      # mix local.hex
      # mix archive.install hex phx_new 1.4.10
      # mix ecto.create
      help () {
        echo "Create new app: mix phx.new app"
        echo "Start server: mix phx.server"
      }
    '';
}
