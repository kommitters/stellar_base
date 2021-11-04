defmodule Stellar.XDR.Signers do
  @moduledoc """
  Representation of a Stellar `Signers` list.
  """
  alias Stellar.XDR.Signer

  @behaviour XDR.Declaration

  @max_length 20

  @array_type Signer

  @array_spec %{type: @array_type, max_length: @max_length}

  @type signers :: list(Signer.t())

  @type t :: %__MODULE__{signers: signers()}

  defstruct [:signers]

  @spec new(signers :: signers()) :: t()
  def new(signers), do: %__MODULE__{signers: signers}

  @impl true
  def encode_xdr(%__MODULE__{signers: signers}) do
    signers
    |> XDR.VariableArray.new(@array_type, @max_length)
    |> XDR.VariableArray.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{signers: signers}) do
    signers
    |> XDR.VariableArray.new(@array_type, @max_length)
    |> XDR.VariableArray.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ @array_spec)

  def decode_xdr(bytes, spec) do
    case XDR.VariableArray.decode_xdr(bytes, spec) do
      {:ok, {signers, rest}} -> {:ok, {new(signers), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ @array_spec)

  def decode_xdr!(bytes, spec) do
    {signers, rest} = XDR.VariableArray.decode_xdr!(bytes, spec)
    {new(signers), rest}
  end
end
