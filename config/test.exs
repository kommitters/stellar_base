use Mix.Config

config :stellar,
  http_client: Stellar.Horizon.HackneyMock,
  network: :test
