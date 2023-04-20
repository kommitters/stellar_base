defmodule StellarBase.XDR.OptionalSCVec do
  @moduledoc """
  Representation of Stellar `OptionalSCVec` type.
  """

  alias StellarBase.XDR.SCVec

  @behaviour XDR.Declaration

  @optional_spec XDR.Optional.new(SCVec)

  @type sc_vec :: SCVec.t() | nil

  @type t :: %__MODULE__{sc_vec: sc_vec()}

  defstruct [:sc_vec]

  @spec new(sc_vec :: sc_vec()) :: t()
  def new(sc_vec \\ nil), do: %__MODULE__{sc_vec: sc_vec}

  @impl true
  def encode_xdr(%__MODULE__{sc_vec: sc_vec}) do
    sc_vec
    |> XDR.Optional.new()
    |> XDR.Optional.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{sc_vec: sc_vec}) do
    sc_vec
    |> XDR.Optional.new()
    |> XDR.Optional.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, optional_spec \\ @optional_spec)

  def decode_xdr(bytes, optional_spec) do
    case XDR.Optional.decode_xdr(bytes, optional_spec) do
      {:ok, {%XDR.Optional{type: sc_vec}, rest}} ->
        {:ok, {new(sc_vec), rest}}

      {:ok, {nil, rest}} ->
        {:ok, {new(), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, optional_spec \\ @optional_spec)

  def decode_xdr!(bytes, optional_spec) do
    case XDR.Optional.decode_xdr!(bytes, optional_spec) do
      {%XDR.Optional{type: sc_vec}, rest} -> {new(sc_vec), rest}
      {nil, rest} -> {new(), rest}
    end
  end
end
