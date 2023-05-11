defmodule StellarBase.XDR.ContractEvent do
  @moduledoc """
  Automatically generated by xdrgen
  DO NOT EDIT or your changes may be overwritten

  Target implementation: elixir_xdr at https://hex.pm/packages/elixir_xdr

  Representation of Stellar `ContractEvent` type.
  """

  @behaviour XDR.Declaration

  alias StellarBase.XDR.{
    ExtensionPoint,
    OptionalHash,
    ContractEventType,
    ContractEventBody
  }

  @struct_spec XDR.Struct.new(
    ext: ExtensionPoint,
    contract_id: OptionalHash,
    type: ContractEventType,
    body: ContractEventBody
  )

  @type type_ext :: ExtensionPoint.t()
  @type type_contract_id :: OptionalHash.t()
  @type type_type :: ContractEventType.t()
  @type type_body :: ContractEventBody.t()

  @type t :: %__MODULE__{ext: type_ext(), contract_id: type_contract_id(), type: type_type(), body: type_body()}

  defstruct [:ext, :contract_id, :type, :body]

  @spec new(ext :: type_ext(), contract_id :: type_contract_id(), type :: type_type(), body :: type_body()) :: t()
  def new(
    %ExtensionPoint{} = ext,
    %OptionalHash{} = contract_id,
    %ContractEventType{} = type,
    %ContractEventBody{} = body
  ),
  do: %__MODULE__{ext: ext, contract_id: contract_id, type: type, body: body}

  @impl true
  def encode_xdr(%__MODULE__{ext: ext, contract_id: contract_id, type: type, body: body}) do
    [ext: ext, contract_id: contract_id, type: type, body: body]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{ext: ext, contract_id: contract_id, type: type, body: body}) do
    [ext: ext, contract_id: contract_id, type: type, body: body]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [ext: ext, contract_id: contract_id, type: type, body: body]}, rest}} ->
        {:ok, {new(ext, contract_id, type, body), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [ext: ext, contract_id: contract_id, type: type, body: body]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)
    {new(ext, contract_id, type, body), rest}
  end
end
