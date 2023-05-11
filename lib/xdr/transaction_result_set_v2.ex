defmodule StellarBase.XDR.TransactionResultSetV2 do
  @moduledoc """
  Automatically generated by xdrgen
  DO NOT EDIT or your changes may be overwritten

  Target implementation: elixir_xdr at https://hex.pm/packages/elixir_xdr

  Representation of Stellar `TransactionResultSetV2` type.
  """

  @behaviour XDR.Declaration

  alias StellarBase.XDR.{
    TransactionResultPairV2List
  }

  @struct_spec XDR.Struct.new(
    results: TransactionResultPairV2List
  )

  @type type_results :: TransactionResultPairV2List.t()

  @type t :: %__MODULE__{results: type_results()}

  defstruct [:results]

  @spec new(results :: type_results()) :: t()
  def new(
    %TransactionResultPairV2List{} = results
  ),
  do: %__MODULE__{results: results}

  @impl true
  def encode_xdr(%__MODULE__{results: results}) do
    [results: results]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{results: results}) do
    [results: results]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [results: results]}, rest}} ->
        {:ok, {new(results), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [results: results]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)
    {new(results), rest}
  end
end
