defmodule Stellar.KeyPair.Default do
  @moduledoc """
  Functions for Ed25519 KeyPairs.
  """

  alias Stellar.Ed25519.{PublicKey, SecretSeed}

  @behaviour Stellar.KeyPair.Spec

  @impl true
  def random do
    {secret, public_key} = Ed25519.generate_key_pair()
    encoded_public_key = PublicKey.encode!(public_key)
    encoded_secret = SecretSeed.encode!(secret)

    {encoded_public_key, encoded_secret}
  end

  @impl true
  def from_secret(secret) do
    decoded_secret = SecretSeed.decode!(secret)
    derived_public_key = Ed25519.derive_public_key(decoded_secret)
    encoded_public_key = PublicKey.encode!(derived_public_key)

    {encoded_public_key, secret}
  end
end
