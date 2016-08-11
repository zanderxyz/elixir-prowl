defmodule Prowl.Mixfile do
  use Mix.Project

  def project do
    [app: :prowl,
     version: "0.0.1",
     elixir: "~> 1.2",
     description: "Elixir application for sending notifications to Prowl (http://www.prowlapp.com/)",
     package: package,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [applications: [:logger]]
  end

  def package do
    [
     name: :prowl,
     files: ["lib", "LICENSE", "mix.exs", "mix.lock", "README.md"],
     maintainers: ["Zander Khan"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/zanderxyz/elixir-prowl"}
   ]
  end

  defp deps do
    [{:httpoison, "~> 0.8.0"},
     {:floki, "~> 0.9.0"}]
  end
end
