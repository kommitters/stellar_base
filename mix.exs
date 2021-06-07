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
      extra_applications: [:logger],
      mod: {Stellar.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:hackney, "~> 1.17", optional: true},
      {:elixir_xdr, "~> 0.1.4"},
      {:ed25519, "~> 1.3"},
      {:crc, "~> 0.10.0"},
      {:mox, "~> 1.0", only: :test}
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
