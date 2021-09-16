defmodule Stellar.XDR.AssetCode12 do
  @moduledoc """
  Representation of Stellar `AssetCode12` type.
  """
  @behaviour XDR.Declaration

  @type t :: %__MODULE__{code: String.t(), length: non_neg_integer()}

  defstruct [:code, :length]

  @length_range 5..12

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

  def encode_xdr!(_asset_code), do: raise(Stellar.XDR.AssetCode12Error, :invalid_length)

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
  defp opaque_spec(bytes), do: XDR.FixedOpaque.new(nil, opaque_length(bytes))

  @spec opaque_length(bytes :: binary()) :: non_neg_integer()
  defp opaque_length(<<bytes::binary-size(8)>>), do: length_from_binary(bytes, 8, 5)
  defp opaque_length(bytes), do: length_from_binary(bytes, 12, 5)

  @spec length_from_binary(
          bytes :: binary(),
          binary_size :: non_neg_integer(),
          acc :: non_neg_integer()
        ) :: non_neg_integer()
  defp length_from_binary(bytes, binary_size, acc)
       when is_binary(bytes) and acc in @length_range do
    <<_hd::binary-size(acc), rest::binary>> = bytes

    residual_zero_bytes =
      (binary_size - acc)
      |> (&List.duplicate(0, &1)).()
      |> to_string()

    if residual_zero_bytes == rest, do: acc, else: length_from_binary(bytes, binary_size, acc + 1)
  end

  defp length_from_binary(_bytes, _acc, _binary_size), do: 12
end
