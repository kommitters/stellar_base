defmodule Stellar.KeyPair.Spec do
  @moduledoc """
  Specifies a behaviour for Ed25519 KeyPair generators.
  This Library allows you to use any crypto package of your choice. The default is Ed25519.
  """

  @callback random :: {String.t(), String.t()}
  @callback from_secret(String.t()) :: {String.t(), String.t()}
end
