defmodule StellarBase.XDR.LedgerKeyContractData do
  @moduledoc """
  Automatically generated by xdrgen
  DO NOT EDIT or your changes may be overwritten

  Target implementation: elixir_xdr at https://hex.pm/packages/elixir_xdr

  Representation of Stellar `LedgerKeyContractData` type.
  """

  @behaviour XDR.Declaration

  alias StellarBase.XDR.{
    SCAddress,
    SCVal,
    ContractDataDurability,
    ContractEntryBodyType
  }

  @struct_spec XDR.Struct.new(
                 contract: SCAddress,
                 key: SCVal,
                 durability: ContractDataDurability,
                 body_type: ContractEntryBodyType
               )

  @type contract_type :: SCAddress.t()
  @type key_type :: SCVal.t()
  @type durability_type :: ContractDataDurability.t()
  @type body_type_type :: ContractEntryBodyType.t()

  @type t :: %__MODULE__{
          contract: contract_type(),
          key: key_type(),
          durability: durability_type(),
          body_type: body_type_type()
        }

  defstruct [:contract, :key, :durability, :body_type]

  @spec new(
          contract :: contract_type(),
          key :: key_type(),
          durability :: durability_type(),
          body_type :: body_type_type()
        ) :: t()
  def new(
        %SCAddress{} = contract,
        %SCVal{} = key,
        %ContractDataDurability{} = durability,
        %ContractEntryBodyType{} = body_type
      ),
      do: %__MODULE__{contract: contract, key: key, durability: durability, body_type: body_type}

  @impl true
  def encode_xdr(%__MODULE__{
        contract: contract,
        key: key,
        durability: durability,
        body_type: body_type
      }) do
    [contract: contract, key: key, durability: durability, body_type: body_type]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{
        contract: contract,
        key: key,
        durability: durability,
        body_type: body_type
      }) do
    [contract: contract, key: key, durability: durability, body_type: body_type]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok,
       {%XDR.Struct{
          components: [contract: contract, key: key, durability: durability, body_type: body_type]
        }, rest}} ->
        {:ok, {new(contract, key, durability, body_type), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{
       components: [contract: contract, key: key, durability: durability, body_type: body_type]
     }, rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(contract, key, durability, body_type), rest}
  end
end