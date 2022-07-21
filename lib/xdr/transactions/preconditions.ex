defmodule StellarBase.XDR.Preconditions do
  @moduledoc """
  Representation of Stellar `Preconditions` type.
  """
  alias StellarBase.XDR.{
    PreconditionType,
    TimeBounds,
    PreconditionsV2,
    Void
  }

  @behaviour XDR.Declaration

  @arms [
    PRECOND_NONE: Void,
    PRECOND_TIME: TimeBounds,
    PRECOND_V2: PreconditionsV2
  ]

  @type preconditions ::
          Void | TimeBounds.t() | PreconditionsV2.t()

  @type t :: %__MODULE__{preconditions: preconditions(), type: PreconditionType.t()}

  defstruct [:preconditions, :type]

  @spec new(preconditions :: preconditions(), type :: PreconditionType.t()) :: t()
  def new(preconditions, %PreconditionType{} = type),
    do: %__MODULE__{preconditions: preconditions, type: type}

  @impl true
  def encode_xdr(%__MODULE__{preconditions: preconditions, type: type}) do
    type
    |> XDR.Union.new(@arms, preconditions)
    |> XDR.Union.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{preconditions: preconditions, type: type}) do
    type
    |> XDR.Union.new(@arms, preconditions)
    |> XDR.Union.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ union_spec())

  def decode_xdr(bytes, spec) do
    case XDR.Union.decode_xdr(bytes, spec) do
      {:ok, {{type, preconditions}, rest}} -> {:ok, {new(preconditions, type), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ union_spec())

  def decode_xdr!(bytes, spec) do
    {{type, preconditions}, rest} = XDR.Union.decode_xdr!(bytes, spec)
    {new(preconditions, type), rest}
  end

  @spec union_spec() :: XDR.Union.t()
  defp union_spec do
    nil
    |> PreconditionType.new()
    |> XDR.Union.new(@arms)
  end
end
