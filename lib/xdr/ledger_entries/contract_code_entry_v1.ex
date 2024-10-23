defmodule StellarBase.XDR.ContractCodeEntryV1 do
  @moduledoc """
  Automatically generated by xdrgen
  DO NOT EDIT or your changes may be overwritten

  Target implementation: elixir_xdr at https://hex.pm/packages/elixir_xdr

  Representation of Stellar `ContractCodeEntryV1` type.
  """

  @behaviour XDR.Declaration

  alias StellarBase.XDR.{
    ExtensionPoint,
    ContractCodeCostInputs
  }

  @struct_spec XDR.Struct.new(
                 ext: ExtensionPoint,
                 cost_inputs: ContractCodeCostInputs
               )

  @type ext_type :: ExtensionPoint.t()
  @type cost_inputs_type :: ContractCodeCostInputs.t()

  @type t :: %__MODULE__{ext: ext_type(), cost_inputs: cost_inputs_type()}

  defstruct [:ext, :cost_inputs]

  @spec new(ext :: ext_type(), cost_inputs :: cost_inputs_type()) :: t()
  def new(
        %ExtensionPoint{} = ext,
        %ContractCodeCostInputs{} = cost_inputs
      ),
      do: %__MODULE__{ext: ext, cost_inputs: cost_inputs}

  @impl true
  def encode_xdr(%__MODULE__{ext: ext, cost_inputs: cost_inputs}) do
    [ext: ext, cost_inputs: cost_inputs]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{ext: ext, cost_inputs: cost_inputs}) do
    [ext: ext, cost_inputs: cost_inputs]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [ext: ext, cost_inputs: cost_inputs]}, rest}} ->
        {:ok, {new(ext, cost_inputs), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [ext: ext, cost_inputs: cost_inputs]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(ext, cost_inputs), rest}
  end
end