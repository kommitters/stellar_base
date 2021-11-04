defmodule StellarBase.XDR.ClaimPredicates do
  @moduledoc """
  Representation of a Stellar `Predicates` list.
  """
  alias StellarBase.XDR.ClaimPredicate

  @behaviour XDR.Declaration

  @max_length 2

  @array_type ClaimPredicate

  @array_spec %{type: @array_type, max_length: @max_length}

  @type t :: %__MODULE__{predicates: list(ClaimPredicate.t())}

  defstruct [:predicates]

  @spec new(predicates :: list(ClaimPredicate.t())) :: t()
  def new(predicates), do: %__MODULE__{predicates: predicates}

  @impl true
  def encode_xdr(%__MODULE__{predicates: predicates}) do
    predicates
    |> XDR.VariableArray.new(@array_type, @max_length)
    |> XDR.VariableArray.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{predicates: predicates}) do
    predicates
    |> XDR.VariableArray.new(@array_type, @max_length)
    |> XDR.VariableArray.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ @array_spec)

  def decode_xdr(bytes, spec) do
    case XDR.VariableArray.decode_xdr(bytes, spec) do
      {:ok, {predicates, rest}} -> {:ok, {new(predicates), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ @array_spec)

  def decode_xdr!(bytes, spec) do
    {predicates, rest} = XDR.VariableArray.decode_xdr!(bytes, spec)
    {new(predicates), rest}
  end
end
