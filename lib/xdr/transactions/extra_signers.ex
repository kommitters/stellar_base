defmodule StellarBase.XDR.ExtraSigners do
  @moduledoc """
  Representation of a Stellar `SignerKey` list.
  """
  alias StellarBase.XDR.SignerKey

  @behaviour XDR.Declaration

  @max_length 2

  @array_type SignerKey

  @array_spec %{type: @array_type, max_length: @max_length}

  @type t :: %__MODULE__{signer_keys: list(SignerKey.t())}

  defstruct [:signer_keys]

  @spec new(signer_keys :: list(SignerKey.t())) :: t()
  def new(signer_keys), do: %__MODULE__{signer_keys: signer_keys}

  @impl true
  def encode_xdr(%__MODULE__{signer_keys: signer_keys}) do
    signer_keys
    |> XDR.VariableArray.new(@array_type, @max_length)
    |> XDR.VariableArray.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{signer_keys: signer_keys}) do
    signer_keys
    |> XDR.VariableArray.new(@array_type, @max_length)
    |> XDR.VariableArray.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ @array_spec)

  def decode_xdr(bytes, spec) do
    case XDR.VariableArray.decode_xdr(bytes, spec) do
      {:ok, {signer_keys, rest}} -> {:ok, {new(signer_keys), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ @array_spec)

  def decode_xdr!(bytes, spec) do
    {signer_keys, rest} = XDR.VariableArray.decode_xdr!(bytes, spec)
    {new(signer_keys), rest}
  end
end
