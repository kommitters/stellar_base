use Mix.Config

config :stellar_base,
  http_client: Stellar.Horizon.HackneyMock,
  network: :test
