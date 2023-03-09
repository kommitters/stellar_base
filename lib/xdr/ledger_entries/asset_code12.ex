defmodule StellarBase.XDR.AssetCode12 do
  @moduledoc """
  Representation of Stellar `AssetCode12` type.
  """

  @behaviour XDR.Declaration

  @type t :: %__MODULE__{code: String.t(), length: non_neg_integer()}

  defstruct [:code, :length]

  @max_length 12
  @length_range 5..@max_length

  @spec new(code :: String.t()) :: t()
  def new(code), do: %__MODULE__{code: code, length: byte_size(code)}

  @impl true
  def encode_xdr(%__MODULE__{code: code, length: length}) when length in @length_range do
    code
    |> build_opaque(length)
    |> XDR.FixedOpaque.encode_xdr()
  end

  def encode_xdr(_asset_code), do: {:error, :invalid_length}

  @impl true
  def encode_xdr!(%__MODULE__{code: code, length: length}) when length in @length_range do
    code
    |> build_opaque(length)
    |> XDR.FixedOpaque.encode_xdr!()
  end

  def encode_xdr!(_asset_code), do: raise(StellarBase.XDR.AssetCode12Error, :invalid_length)

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

  def decode_xdr!(<<bytes::binary-size(12), rest::binary>>, _term) do
    {%XDR.FixedOpaque{opaque: code}, _rest} =
      XDR.FixedOpaque.decode_xdr!(bytes, opaque_spec(bytes))

    {new(code), rest}
  end

  @spec build_opaque(code :: binary(), length :: non_neg_integer()) :: XDR.FixedOpaque.t()
  defp build_opaque(code, length) do
    zeros = @max_length - length
    bin = <<code::binary, 0::zeros()*8>>
    XDR.FixedOpaque.new(bin, @max_length)
  end

  @spec opaque_spec(bytes :: binary()) :: XDR.FixedOpaque.t()
  defp opaque_spec(bytes), do: XDR.FixedOpaque.new(nil, length_from_binary(bytes, 5))

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
