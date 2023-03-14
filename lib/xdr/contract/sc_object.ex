defmodule StellarBase.XDR.SCObject do
  @moduledoc """
  Representation of Stellar `SCObjectStellarBase.XDR.SCObject` type.
  """
  alias StellarBase.XDR.{AccountID, Hash, SCAddressType}

  @behaviour XDR.Declaration

  @arms [
    SC_ADDRESS_TYPE_ACCOUNT: AccountID,
    SC_ADDRESS_TYPE_CONTRACT: Hash
  ]

  @type sc_address :: AccountID.t() | Hash.t()

  @type t :: %__MODULE__{sc_address: sc_address(), type: SCAddressType.t()}

  defstruct [:sc_address, :type]

  @spec new(sc_address :: sc_address(), type :: SCAddressType.t()) :: t()
  def new(sc_address, %SCAddressType{} = type),
    do: %__MODULE__{sc_address: sc_address, type: type}

  @impl true
  def encode_xdr(%__MODULE__{sc_address: sc_address, type: type}) do
    type
    |> XDR.Union.new(@arms, sc_address)
    |> XDR.Union.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{sc_address: sc_address, type: type}) do
    type
    |> XDR.Union.new(@arms, sc_address)
    |> XDR.Union.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ union_spec())

  def decode_xdr(bytes, spec) do
    case XDR.Union.decode_xdr(bytes, spec) do
      {:ok, {{type, sc_address}, rest}} -> {:ok, {new(sc_address, type), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ union_spec())

  def decode_xdr!(bytes, spec) do
    {{type, sc_address}, rest} = XDR.Union.decode_xdr!(bytes, spec)
    {new(sc_address, type), rest}
  end

  @spec union_spec() :: XDR.Union.t()
  defp union_spec do
    nil
    |> SCAddressType.new()
    |> XDR.Union.new(@arms)
  end
end
