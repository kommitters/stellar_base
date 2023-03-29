defmodule StellarBase.XDR.ContractAuthList do
  @moduledoc """
  Representation of a Stellar `ContractAuthList` list.
  """
  alias StellarBase.XDR.ContractAuth

  @behaviour XDR.Declaration

  @max_length 4_294_967_295

  @array_type ContractAuth

  @array_spec %{type: @array_type, max_length: @max_length}

  @type t :: %__MODULE__{auth: list(ContractAuth.t())}

  defstruct [:auth]

  @spec new(auth :: list(ContractAuth.t())) :: t()
  def new(auth), do: %__MODULE__{auth: auth}

  @impl true
  def encode_xdr(%__MODULE__{auth: auth}) do
    auth
    |> XDR.VariableArray.new(@array_type, @max_length)
    |> XDR.VariableArray.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{auth: auth}) do
    auth
    |> XDR.VariableArray.new(@array_type, @max_length)
    |> XDR.VariableArray.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ @array_spec)

  def decode_xdr(bytes, spec) do
    case XDR.VariableArray.decode_xdr(bytes, spec) do
      {:ok, {auth, rest}} -> {:ok, {new(auth), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ @array_spec)

  def decode_xdr!(bytes, spec) do
    {auth, rest} = XDR.VariableArray.decode_xdr!(bytes, spec)
    {new(auth), rest}
  end
end
