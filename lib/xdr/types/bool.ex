defmodule StellarBase.XDR.Bool do
  @moduledoc """
  Representation of Stellar `Bool` type.
  """

  @behaviour XDR.Declaration

  @type t :: %__MODULE__{value: boolean()}

  defstruct [:value]

  @spec new(value :: boolean()) :: t()
  def new(val), do: %__MODULE__{value: val}

  @impl true
  def encode_xdr(%__MODULE__{value: value}) do
    XDR.Bool.encode_xdr(%XDR.Bool{identifier: value})
  end

  @impl true
  def encode_xdr!(%__MODULE__{value: value}) do
    XDR.Bool.encode_xdr!(%XDR.Bool{identifier: value})
  end

  @impl true
  def decode_xdr(bytes, term \\ nil)

  def decode_xdr(bytes, _term) do
    case XDR.Bool.decode_xdr(bytes) do
      {:ok, {%XDR.Bool{identifier: val}, rest}} -> {:ok, {new(val), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, term \\ nil)

  def decode_xdr!(bytes, _term) do
    {%XDR.Bool{identifier: val}, rest} = XDR.Bool.decode_xdr!(bytes)
    {new(val), rest}
  end
end
