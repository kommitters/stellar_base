defmodule StellarBase.XDR.SCSpecUDTUnionCaseV0 do
  @moduledoc """
  Representation of Stellar `SCSpecUDTUnionCaseV0` kind.
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

  @type code ::
          SCSpecUDTUnionCaseVoidV0.t()
          | SCSpecUDTUnionCaseTupleV0.t()

  @type kind :: SCSpecUDTUnionCaseV0Kind.t()

  @type t :: %__MODULE__{code: code(), kind: kind()}

  defstruct [:code, :kind]

  @spec new(code :: code(), kind :: kind()) :: t()
  def new(code, %SCSpecUDTUnionCaseV0Kind{} = kind), do: %__MODULE__{code: code, kind: kind}

  @impl true
  def encode_xdr(%__MODULE__{code: code, kind: kind}) do
    kind
    |> XDR.Union.new(@arms, code)
    |> XDR.Union.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{code: code, kind: kind}) do
    kind
    |> XDR.Union.new(@arms, code)
    |> XDR.Union.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ union_spec())

  def decode_xdr(bytes, spec) do
    case XDR.Union.decode_xdr(bytes, spec) do
      {:ok, {{kind, code}, rest}} -> {:ok, {new(code, kind), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ union_spec())

  def decode_xdr!(bytes, spec) do
    {{kind, code}, rest} = XDR.Union.decode_xdr!(bytes, spec)
    {new(code, kind), rest}
  end

  @spec union_spec() :: XDR.Union.t()
  defp union_spec do
    nil
    |> SCSpecUDTUnionCaseV0Kind.new()
    |> XDR.Union.new(@arms)
  end
end
