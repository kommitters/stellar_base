defmodule StellarBase.XDR.OperationID do
  @moduledoc """
  Representation of Stellar `OperationID` type.
  """
  alias StellarBase.XDR.{AccountID, SequenceNumber, UInt32}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(
                 source_account: AccountID,
                 sequence_number: SequenceNumber,
                 op_num: UInt32
               )

  @type t :: %__MODULE__{
          source_account: AccountID.t(),
          sequence_number: SequenceNumber.t(),
          op_num: UInt32.t()
        }

  defstruct [:source_account, :sequence_number, :op_num]

  @spec new(
          source_account :: AccountID.t(),
          sequence_number :: SequenceNumber.t(),
          op_num :: UInt32.t()
        ) :: t()
  def new(%AccountID{} = source_account, %SequenceNumber{} = sequence_number, %UInt32{} = op_num),
    do: %__MODULE__{
      source_account: source_account,
      sequence_number: sequence_number,
      op_num: op_num
    }

  @impl true
  def encode_xdr(%__MODULE__{
        source_account: source_account,
        sequence_number: sequence_number,
        op_num: op_num
      }) do
    [source_account: source_account, sequence_number: sequence_number, op_num: op_num]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{
        source_account: source_account,
        sequence_number: sequence_number,
        op_num: op_num
      }) do
    [source_account: source_account, sequence_number: sequence_number, op_num: op_num]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok,
       {%XDR.Struct{
          components: [
            source_account: source_account,
            sequence_number: sequence_number,
            op_num: op_num
          ]
        }, rest}} ->
        {:ok, {new(source_account, sequence_number, op_num), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{
       components: [
         source_account: source_account,
         sequence_number: sequence_number,
         op_num: op_num
       ]
     }, rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(source_account, sequence_number, op_num), rest}
  end
end
