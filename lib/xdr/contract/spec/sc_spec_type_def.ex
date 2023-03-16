defmodule StellarBase.XDR.SCSpecTypeDef do
  @moduledoc """
  Representation of Stellar `SCSpecTypeDef` type.
  """

  alias StellarBase.XDR.{Void, SCSpecType}

  @behaviour XDR.Declaration

  @arms [
    SC_SPEC_TYPE_VAL: Void
  ]

  @type sc_spec_type_def :: Void.t()

  @type t :: %__MODULE__{sc_spec_type_def: sc_spec_type_def(), type: SCSpecType.t()}

  defstruct [:sc_spec_type_def, :type]

  @spec new(sc_spec_type_def :: sc_spec_type_def(), type :: SCSpecType.t()) :: t()
  def new(sc_spec_type_def, %SCSpecType{} = type),
    do: %__MODULE__{sc_spec_type_def: sc_spec_type_def, type: type}

  @impl true
  def encode_xdr(%__MODULE__{sc_spec_type_def: sc_spec_type_def, type: type}) do
    type
    |> XDR.Union.new(@arms, sc_spec_type_def)
    |> XDR.Union.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{sc_spec_type_def: sc_spec_type_def, type: type}) do
    type
    |> XDR.Union.new(@arms, sc_spec_type_def)
    |> XDR.Union.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ union_spec())

  def decode_xdr(bytes, spec) do
    case XDR.Union.decode_xdr(bytes, spec) do
      {:ok, {{type, sc_spec_type_def}, rest}} -> {:ok, {new(sc_spec_type_def, type), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ union_spec())

  def decode_xdr!(bytes, spec) do
    {{type, sc_spec_type_def}, rest} = XDR.Union.decode_xdr!(bytes, spec)
    {new(sc_spec_type_def, type), rest}
  end

  @spec union_spec() :: XDR.Union.t()
  defp union_spec do
    nil
    |> SCSpecType.new()
    |> XDR.Union.new(@arms)
  end
end
