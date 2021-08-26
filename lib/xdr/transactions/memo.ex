defmodule Stellar.XDR.Memo do
  @moduledoc """
  Representation of Stellar `Memo` type.
  """
  alias Stellar.XDR.{Void, UInt64, Hash, MemoType, String28}

  @behaviour XDR.Declaration

  @arms [
    MEMO_NONE: Void,
    MEMO_TEXT: String28,
    MEMO_ID: UInt64,
    MEMO_HASH: Hash,
    MEMO_RETURN: Hash
  ]

  @type memo_value :: Void.t() | UInt64.t() | Hash.t() | String28.t()

  @type t :: %__MODULE__{value: memo_value(), type: MemoType.t()}

  defstruct [:value, :type]

  @spec new(value :: memo_value(), type :: MemoType.t()) :: t()
  def new(value, %MemoType{} = type),
    do: %__MODULE__{value: value, type: type}

  @impl true
  def encode_xdr(%__MODULE__{value: value, type: type}) do
    type
    |> XDR.Union.new(@arms, value)
    |> XDR.Union.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{value: value, type: type}) do
    type
    |> XDR.Union.new(@arms, value)
    |> XDR.Union.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ union_spec())

  def decode_xdr(bytes, spec) do
    case XDR.Union.decode_xdr(bytes, spec) do
      {:ok, {{type, value}, rest}} -> {:ok, {new(value, type), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ union_spec())

  def decode_xdr!(bytes, spec) do
    {{type, value}, rest} = XDR.Union.decode_xdr!(bytes, spec)
    {new(value, type), rest}
  end

  @spec union_spec() :: XDR.Union.t()
  defp union_spec do
    :MEMO_NONE
    |> MemoType.new()
    |> XDR.Union.new(@arms)
  end
end
