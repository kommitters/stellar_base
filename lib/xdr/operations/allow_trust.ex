defmodule StellarBase.XDR.Operations.AllowTrust do
  @moduledoc """
  Representation of Stellar `AllowTrust` type.
  """
  alias StellarBase.XDR.{AccountID, Asset, UInt32}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(trustor: AccountID, asset_code: Asset, authorize: UInt32)

  @type t :: %__MODULE__{trustor: AccountID.t(), asset_code: Asset.t(), authorize: UInt32.t()}

  defstruct [:trustor, :asset_code, :authorize]

  @spec new(trustor :: AccountID.t(), asset_code :: Asset.t(), authorize :: UInt32.t()) :: t()
  def new(%AccountID{} = trustor, %Asset{} = asset_code, %UInt32{} = authorize),
    do: %__MODULE__{trustor: trustor, asset_code: asset_code, authorize: authorize}

  @impl true
  def encode_xdr(%__MODULE__{trustor: trustor, asset_code: asset_code, authorize: authorize}) do
    [trustor: trustor, asset_code: asset_code, authorize: authorize]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{trustor: trustor, asset_code: asset_code, authorize: authorize}) do
    [trustor: trustor, asset_code: asset_code, authorize: authorize]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok,
       {%XDR.Struct{components: [trustor: trustor, asset_code: asset_code, authorize: authorize]},
        rest}} ->
        {:ok, {new(trustor, asset_code, authorize), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [trustor: trustor, asset_code: asset_code, authorize: authorize]},
     rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(trustor, asset_code, authorize), rest}
  end
end
