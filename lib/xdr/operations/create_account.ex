defmodule StellarBase.XDR.Operations.CreateAccount do
  @moduledoc """
  Representation of Stellar `CreateAccount` type.
  """
  alias StellarBase.XDR.{AccountID, Int64}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(destination: AccountID, starting_balance: Int64)

  @type t :: %__MODULE__{destination: AccountID.t(), starting_balance: Int64.t()}

  defstruct [:destination, :starting_balance]

  @spec new(destination :: AccountID.t(), starting_balance :: Int64.t()) :: t()
  def new(%AccountID{} = destination, %Int64{} = starting_balance),
    do: %__MODULE__{destination: destination, starting_balance: starting_balance}

  @impl true
  def encode_xdr(%__MODULE__{destination: destination, starting_balance: starting_balance}) do
    [destination: destination, starting_balance: starting_balance]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{destination: destination, starting_balance: starting_balance}) do
    [destination: destination, starting_balance: starting_balance]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok,
       {%XDR.Struct{components: [destination: destination, starting_balance: starting_balance]},
        rest}} ->
        {:ok, {new(destination, starting_balance), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [destination: destination, starting_balance: starting_balance]},
     rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(destination, starting_balance), rest}
  end
end
