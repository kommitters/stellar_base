defmodule Stellar.KeyPair do
  @moduledoc false

  @behaviour Stellar.KeyPair.Spec

  @impl true
  def random, do: current_impl().random()

  @impl true
  def from_secret(secret), do: current_impl().from_secret(secret)

  defp current_impl do
    Application.get_env(:stellar, :ed25519_module, Stellar.KeyPair.Default)
  end
end
