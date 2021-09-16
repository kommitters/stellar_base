defmodule Stellar.XDR.AssetCode4 do
  @moduledoc """
  Representation of Stellar `AssetCode4` type.
  """
  @behaviour XDR.Declaration

  @type t :: %__MODULE__{code: String.t(), length: non_neg_integer()}

  defstruct [:code, :length]

  @max_length 4
  @length_range 1..@max_length

  @spec new(code :: String.t()) :: t()
  def new(code), do: %__MODULE__{code: code, length: byte_size(code)}

  @impl true
  def encode_xdr(%__MODULE__{code: code, length: length}) when length in @length_range do
    code
    |> XDR.FixedOpaque.new(length)
    |> XDR.FixedOpaque.encode_xdr()
  end

  def encode_xdr(_asset_code), do: {:error, :invalid_length}

  @impl true
  def encode_xdr!(%__MODULE__{code: code, length: length}) when length in @length_range do
    code
    |> XDR.FixedOpaque.new(length)
    |> XDR.FixedOpaque.encode_xdr!()
  end

  def encode_xdr!(_asset_code), do: raise(Stellar.XDR.AssetCode4Error, :invalid_length)

  @impl true
  def decode_xdr(bytes, term \\ nil)

  def decode_xdr(bytes, _term) do
    case XDR.FixedOpaque.decode_xdr(bytes, opaque_spec(bytes)) do
      {:ok, {%XDR.FixedOpaque{opaque: code}, rest}} -> {:ok, {new(code), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, term \\ nil)

  def decode_xdr!(bytes, _term) do
    {%XDR.FixedOpaque{opaque: code}, rest} =
      XDR.FixedOpaque.decode_xdr!(bytes, opaque_spec(bytes))

    {new(code), rest}
  end

  @spec opaque_spec(bytes :: binary()) :: XDR.FixedOpaque.t()
  defp opaque_spec(bytes), do: XDR.FixedOpaque.new(nil, length_from_binary(bytes, 1))

  @spec length_from_binary(bytes :: binary(), acc :: non_neg_integer()) :: non_neg_integer()
  defp length_from_binary(<<opaque::binary-size(@max_length), _rest::binary>>, acc)
       when acc in @length_range do
    <<_hd::binary-size(acc), rest::binary>> = opaque

    residual_zero_bytes =
      (@max_length - acc)
      |> (&List.duplicate(0, &1)).()
      |> to_string()

    if residual_zero_bytes == rest, do: acc, else: length_from_binary(opaque, acc + 1)
  end

  defp length_from_binary(_bytes, _acc), do: @max_length
end
