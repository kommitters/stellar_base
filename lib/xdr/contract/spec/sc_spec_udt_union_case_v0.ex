defmodule StellarBase.XDR.SCSpecUDTUnionCaseV0 do
  @moduledoc """
  Representation of Stellar `SCSpecUDTUnionCaseV0` type.
  """

  alias StellarBase.XDR.{
    SCSpecUDTUnionCaseVoidV0,
    SCSpecUDTUnionCaseTupleV0,
    SCSpecUDTUnionCaseV0Kind
  }

  @behaviour XDR.Declaration

  @arms [
    SC_SPEC_UDT_UNION_CASE_VOID_V0: SCSpecUDTUnionCaseVoidV0,
    SC_SPEC_UDT_UNION_CASE_TUPLE_V0: SCSpecUDTUnionCaseTupleV0
  ]

  @type udt_union_case_v0 :: SCSpecUDTUnionCaseVoidV0.t() | SCSpecUDTUnionCaseTupleV0.t()

  @type t :: %__MODULE__{
          udt_union_case_v0: udt_union_case_v0(),
          type: SCSpecUDTUnionCaseV0Kind.t()
        }

  defstruct [:udt_union_case_v0, :type]

  @spec new(udt_union_case_v0 :: udt_union_case_v0(), type :: SCSpecUDTUnionCaseV0Kind.t()) :: t()
  def new(udt_union_case_v0, %SCSpecUDTUnionCaseV0Kind{} = type),
    do: %__MODULE__{udt_union_case_v0: udt_union_case_v0, type: type}

  @impl true
  def encode_xdr(%__MODULE__{udt_union_case_v0: udt_union_case_v0, type: type}) do
    type
    |> XDR.Union.new(@arms, udt_union_case_v0)
    |> XDR.Union.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{udt_union_case_v0: udt_union_case_v0, type: type}) do
    type
    |> XDR.Union.new(@arms, udt_union_case_v0)
    |> XDR.Union.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ union_spec())

  def decode_xdr(bytes, spec) do
    case XDR.Union.decode_xdr(bytes, spec) do
      {:ok, {{type, udt_union_case_v0}, rest}} -> {:ok, {new(udt_union_case_v0, type), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ union_spec())

  def decode_xdr!(bytes, spec) do
    {{type, udt_union_case_v0}, rest} = XDR.Union.decode_xdr!(bytes, spec)
    {new(udt_union_case_v0, type), rest}
  end

  @spec union_spec() :: XDR.Union.t()
  defp union_spec do
    nil
    |> SCSpecUDTUnionCaseV0Kind.new()
    |> XDR.Union.new(@arms)
  end
end
