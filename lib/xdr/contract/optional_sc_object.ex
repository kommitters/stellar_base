defmodule StellarBase.XDR.OptionalSCObject do
  @moduledoc """
  Representation of Stellar `OptionalSCObject` type.
  """

  alias StellarBase.XDR.SCObject

  @behaviour XDR.Declaration

  @optional_spec XDR.Optional.new(SCObject)

  @type sc_object :: SCObject.t() | nil

  @type t :: %__MODULE__{sc_object: sc_object()}

  defstruct [:sc_object]

  @spec new(sc_object :: sc_object()) :: t()
  def new(sc_object \\ nil), do: %__MODULE__{sc_object: sc_object}

  @impl true
  def encode_xdr(%__MODULE__{sc_object: sc_object}) do
    sc_object
    |> XDR.Optional.new()
    |> XDR.Optional.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{sc_object: sc_object}) do
    sc_object
    |> XDR.Optional.new()
    |> XDR.Optional.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, optional_spec \\ @optional_spec)

  def decode_xdr(bytes, optional_spec) do
    case XDR.Optional.decode_xdr(bytes, optional_spec) do
      {:ok, {%XDR.Optional{type: sc_object}, rest}} ->
        {:ok, {new(sc_object), rest}}

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
      {%XDR.Optional{type: sc_object}, rest} -> {new(sc_object), rest}
      {nil, rest} -> {new(), rest}
    end
  end
end
