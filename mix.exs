defmodule Quizium.MixProject do
  use Mix.Project

  @app :quizium
  @name "Quizium"
  @version "0.1.0-#{Mix.env()}"

  def project do
    [
      app: @app,
      name: @name,
      version: @version,
      git_ref: git_revision_hash(),
      elixir: "~> 1.13",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      preferred_cli_env: [
        check: :test
      ]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Quizium.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      # web
      {:phoenix, "~> 1.6.10"},
      {:phoenix_html, "~> 3.0"},
      {:phoenix_live_view, "~> 0.17.5"},
      {:plug_cowboy, "~> 2.5"},

      # database
      {:phoenix_ecto, "~> 4.4"},
      {:ecto_sql, "~> 3.6"},
      {:ecto_sqlite3, ">= 0.0.0"},

      # mailer
      {:swoosh, "~> 1.3"},

      # i18n
      {:gettext, "~> 0.18"},

      # monitoring
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"},
      {:phoenix_live_dashboard, "~> 0.6"},

      # utilities
      {:jason, "~> 1.2"},

      # development
      {:esbuild, "~> 0.4", runtime: Mix.env() == :dev},
      {:tailwind, "~> 0.1.6", runtime: Mix.env() == :dev},
      {:phoenix_live_reload, "~> 1.2", only: :dev},

      # testing
      {:floki, ">= 0.30.0", only: :test},

      # tools
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.1", only: [:dev, :test], runtime: false}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "ecto.setup"],
      "ecto.seed": ["run priv/repo/seeds.exs"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "ecto.seed"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"],
      "assets.deploy": ["tailwind default --minify", "esbuild default --minify", "phx.digest"],
      lint: ["credo --strict --all"],
      check: [
        "clean",
        "deps.unlock --check-unused",
        "compile --warnings-as-errors",
        "format --check-formatted",
        "deps.unlock --check-unused",
        "test --warnings-as-errors",
        "lint"
      ]
    ]
  end

  defp git_revision_hash do
    case System.cmd("git", ["rev-parse", "HEAD"]) do
      {ref, 0} ->
        ref

      {_, _code} ->
        git_ref = File.read!(".git/HEAD")

        if String.contains?(git_ref, "ref:") do
          ["ref:", ref_path] = String.split(git_ref)
          File.read!(".git/#{ref_path}")
        else
          git_ref
        end
    end
    |> String.replace("\n", "")
  end
end
