defmodule Stellar.MixProject do
  use Mix.Project

  @github_url "https://github.com/kommitters/stellar_sdk"
  @version "0.0.1"

  def project do
    [
      app: :stellar,
      version: @version,
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: "Stellar SDK",
      description: description(),
      source_url: @github_url,
      package: package(),
      docs: docs()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end

  defp description, do: "Elixir SDK for the Stellar network"

  defp package do
    [
      description: description(),
      files: ["lib", "config", "mix.exs", "README*", "LICENSE"],
      licenses: ["MIT"],
      links: %{
        Changelog: "#{@github_url}/blob/master/CHANGELOG.md",
        GitHub: @github_url
      }
    ]
  end

  defp docs do
    [
      main: "readme",
      name: "Stellar SDK",
      source_ref: "v#{@version}",
      source_url: @github_url,
      canonical: "http://hexdocs.pm/stellar_sdk",
      extras: ["README.md", "CHANGELOG.md"]
    ]
  end
end
