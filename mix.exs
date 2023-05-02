defmodule StellarBase.MixProject do
  use Mix.Project

  @github_url "https://github.com/kommitters/stellar_base"
  @version "0.10.1"

  def project do
    [
      app: :stellar_base,
      version: @version,
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: "Elixir Stellar Base",
      description: description(),
      source_url: @github_url,
      package: package(),
      docs: docs(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
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
      {:elixir_xdr, "~> 0.3.0"},
      {:crc, "~> 0.10.0"},
      {:dialyxir, "~> 1.0", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.16", only: :test, runtime: false},
      {:credo, "~> 1.5", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.29", only: :dev, runtime: false}
    ]
  end

  defp description do
    """
    Low-level elixir library to read, write, hash, and sign XDR primitive constructs used in the Stellar network.
    """
  end

  defp package do
    [
      description: description(),
      files: ["lib", "config", "mix.exs", "README*", "LICENSE"],
      licenses: ["MIT"],
      links: %{
        "Changelog" => "#{@github_url}/blob/master/CHANGELOG.md",
        "GitHub" => @github_url,
        "Sponsor" => "https://github.com/sponsors/kommitters"
      }
    ]
  end

  defp docs do
    [
      main: "readme",
      name: "Elixir Stellar Base",
      source_ref: "v#{@version}",
      source_url: @github_url,
      canonical: "http://hexdocs.pm/stellar_base",
      extras: ["README.md", "CHANGELOG.md", "CONTRIBUTING.md"],
      groups_for_modules: groups_for_modules()
    ]
  end

  defp groups_for_modules do
    [
      XDR: ~r/^StellarBase\.XDR\./,
      StrKey: ~r/^StellarBase\.StrKey*/
    ]
  end
end
