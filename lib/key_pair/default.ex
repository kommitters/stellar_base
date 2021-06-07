defmodule Stellar.KeyPair.Default do
  @moduledoc """
  Functions for Ed25519 KeyPairs.
  """

  alias Stellar.StrKey

  @behaviour Stellar.KeyPair.Spec

  @impl true
  def random do
    {secret, public_key} = Ed25519.generate_key_pair()
    encoded_public_key = StrKey.encode!(:ed25519PublicKey, public_key)
    encoded_secret = StrKey.encode!(:ed25519SecretSeed, secret)

    {encoded_public_key, encoded_secret}
  end

  @impl true
  def from_secret(secret) do
    decoded_secret = StrKey.decode!(:ed25519SecretSeed, secret)
    derived_public_key = Ed25519.derive_public_key(decoded_secret)
    encoded_public_key = StrKey.encode!(:ed25519PublicKey, derived_public_key)

    {encoded_public_key, secret}
  end
end
