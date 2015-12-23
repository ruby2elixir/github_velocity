defmodule Logic.Mixfile do
  use Mix.Project

  def project do
    [app: :logic,
     version: "0.0.1",
     deps_path: "../../deps",
     lockfile: "../../mix.lock",
     elixir: "~> 1.1",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :tzdata, :httpotion],
     mod: {Logic, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # To depend on another app inside the umbrella:
  #
  #   {:myapp, in_umbrella: true}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:floki, "~> 0.7"},
      {:elastix, "~> 0.1.0"},
      {:prelude, github: "houshuang/elixir-prelude", ref: "e225b83d631c7db44243c2be46b892dbcc559e66"},
      {:poison, "1.5.0"},
      {:timex, "1.0.0-rc4"},
      {:ibrowse, github: "cmullaparthi/ibrowse", tag: "v4.1.2"},
      {:httpotion, "~> 2.1.0"},
      {:ex_spec, "~> 1.0.0", only: :test}
    ]
  end
end
