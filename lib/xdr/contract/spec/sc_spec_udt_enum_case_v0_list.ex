defmodule StellarBase.XDR.SCSpecUDTEnumCaseV0List do
  @moduledoc """
  Representation of a Stellar `SCSpecUDTEnumCaseV0List` list.
  """
  alias StellarBase.XDR.SCSpecUDTEnumCaseV0

  @behaviour XDR.Declaration

  @max_length 50

  @array_type SCSpecUDTEnumCaseV0

  @array_spec %{type: @array_type, max_length: @max_length}

  @type t :: %__MODULE__{cases: list(SCSpecUDTEnumCaseV0.t())}

  defstruct [:cases]

  @spec new(cases :: list(SCSpecUDTEnumCaseV0.t())) :: t()
  def new(cases), do: %__MODULE__{cases: cases}

  @impl true
  def encode_xdr(%__MODULE__{cases: cases}) do
    cases
    |> XDR.VariableArray.new(@array_type, @max_length)
    |> XDR.VariableArray.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{cases: cases}) do
    cases
    |> XDR.VariableArray.new(@array_type, @max_length)
    |> XDR.VariableArray.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ @array_spec)

  def decode_xdr(bytes, spec) do
    case XDR.VariableArray.decode_xdr(bytes, spec) do
      {:ok, {cases, rest}} -> {:ok, {new(cases), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ @array_spec)

  def decode_xdr!(bytes, spec) do
    {cases, rest} = XDR.VariableArray.decode_xdr!(bytes, spec)
    {new(cases), rest}
  end
end
