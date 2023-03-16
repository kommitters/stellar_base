defmodule StellarBase.XDR.Operations.BeginSponsoringFutureReserves do
  @moduledoc """
  Representation of Stellar `BeginSponsoringFutureReserves` type.
  """
  alias StellarBase.XDR.AccountID

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(sponsored_id: AccountID)

  @type t :: %__MODULE__{sponsored_id: AccountID.t()}

  defstruct [:sponsored_id]

  @spec new(sponsored_id :: AccountID.t()) :: t()
  def new(%AccountID{} = sponsored_id), do: %__MODULE__{sponsored_id: sponsored_id}

  @impl true
  def encode_xdr(%__MODULE__{sponsored_id: sponsored_id}) do
    [sponsored_id: sponsored_id]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{sponsored_id: sponsored_id}) do
    [sponsored_id: sponsored_id]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [sponsored_id: sponsored_id]}, rest}} ->
        {:ok, {new(sponsored_id), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [sponsored_id: sponsored_id]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(sponsored_id), rest}
  end
end
