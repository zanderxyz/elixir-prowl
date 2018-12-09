defmodule Prowl.Mixfile do
  use Mix.Project

  @version "0.1.1"

  def project do
    [
      app: :prowl,
      version: @version,
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      # Hex
      description: description(),
      package: package(),

      # Docs
      name: "Elixir Prowl",
      source_url: "https://github.com/zanderxyz/elixir-prowl",
      homepage_url: "https://github.com/zanderxyz/elixir-prowl",
      docs: [
        source_ref: "v#{@version}",
        main: "Elixir Prowl",
        canonical: "http://hexdocs.pm/elixir-prowl",
        source_url: "https://github.com/zanderxyz/elixir-prowl"
      ]
    ]
  end

  def application do
    [applications: [:logger, :httpoison]]
  end

  # Description for Hex
  defp description do
    """
    Elixir application for sending notifications to [Prowl](https://www.prowlapp.com/).
    """
  end

  # These are the default files included in the package
  defp package do
    [
      maintainers: ["Zander Khan"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/zanderxyz/elixir-prowl"}
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 1.0"},
      {:floki, "~> 0.20"},
      {:ex_doc, ">= 0.0.0"}
    ]
  end
end
