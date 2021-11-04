defmodule StellarBase.XDR.ClaimPredicateType do
  @moduledoc """
  Representation of Stellar `ClaimPredicateType` type.
  """
  @behaviour XDR.Declaration

  @declarations [
    CLAIM_PREDICATE_UNCONDITIONAL: 0,
    CLAIM_PREDICATE_AND: 1,
    CLAIM_PREDICATE_OR: 2,
    CLAIM_PREDICATE_NOT: 3,
    CLAIM_PREDICATE_BEFORE_ABSOLUTE_TIME: 4,
    CLAIM_PREDICATE_BEFORE_RELATIVE_TIME: 5
  ]

  @enum_spec %XDR.Enum{declarations: @declarations, identifier: nil}

  @type t :: %__MODULE__{identifier: atom()}

  defstruct [:identifier]

  @spec new(type :: atom()) :: t()
  def new(type \\ :CLAIMANT_TYPE_V0), do: %__MODULE__{identifier: type}

  @impl true
  def encode_xdr(%__MODULE__{identifier: type}) do
    @declarations
    |> XDR.Enum.new(type)
    |> XDR.Enum.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{identifier: type}) do
    @declarations
    |> XDR.Enum.new(type)
    |> XDR.Enum.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ @enum_spec)

  def decode_xdr(bytes, spec) do
    case XDR.Enum.decode_xdr(bytes, spec) do
      {:ok, {%XDR.Enum{identifier: type}, rest}} -> {:ok, {new(type), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ @enum_spec)

  def decode_xdr!(bytes, spec) do
    {%XDR.Enum{identifier: type}, rest} = XDR.Enum.decode_xdr!(bytes, spec)
    {new(type), rest}
  end
end
