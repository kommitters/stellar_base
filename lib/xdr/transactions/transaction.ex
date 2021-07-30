defmodule Stellar.XDR.Transaction do
  @moduledoc """
  Representation of Stellar `Transaction` type.
  """
  @behaviour XDR.Declaration

  @type t :: %__MODULE__{
          source_account: binary(),
          fee: binary(),
          seq_num: binary(),
          time_bounds: term(),
          memo: term(),
          operations: term(),
          ext: term()
        }

  # @enforce_keys [:source_account, :fee, :seq_num]

  defstruct source_account: nil,
            fee: nil,
            seq_num: nil,
            time_bounds: nil,
            memo: nil,
            operations: nil,
            ext: nil

  @spec new(params :: map()) :: t()
  def new(params),
    do: %__MODULE__{
      source_account: params[:source_account],
      fee: params[:fee],
      seq_num: params[:seq_num],
      time_bounds: params[:time_bounds],
      memo: params[:memo],
      operations: params[:operations],
      ext: params[:ext]
    }

  @impl true
  def encode_xdr(params) do
    params
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(params) do
    params
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, term \\ nil)

  def decode_xdr(bytes, _term) do
    struct_spec = XDR.Struct.new(source_account: XDR.String)

    case XDR.Struct.decode_xdr(bytes, struct_spec) do
      {:ok, {%XDR.Struct{components: components}, rest}} -> {:ok, {new(components), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, term \\ nil)

  def decode_xdr!(bytes, term) do
    {%XDR.Struct{} = struct, rest} = XDR.Struct.decode_xdr!(bytes, term)
    {new(struct), rest}
  end
end
