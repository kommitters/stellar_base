defmodule StellarBase.XDR.SetTrustLineFlagsOp do
  @moduledoc """
  Automatically generated by xdrgen
  DO NOT EDIT or your changes may be overwritten

  Target implementation: elixir_xdr at https://hex.pm/packages/elixir_xdr

  Representation of Stellar `SetTrustLineFlagsOp` type.
  """

  @behaviour XDR.Declaration

  alias StellarBase.XDR.{
    AccountID,
    Asset,
    Uint32
  }

  @struct_spec XDR.Struct.new(
    trustor: AccountID,
    asset: Asset,
    clear_flags: Uint32,
    set_flags: Uint32
  )

  @type type_trustor :: AccountID.t()
  @type type_asset :: Asset.t()
  @type type_clear_flags :: Uint32.t()
  @type type_set_flags :: Uint32.t()

  @type t :: %__MODULE__{trustor: type_trustor(), asset: type_asset(), clear_flags: type_clear_flags(), set_flags: type_set_flags()}

  defstruct [:trustor, :asset, :clear_flags, :set_flags]

  @spec new(trustor :: type_trustor(), asset :: type_asset(), clear_flags :: type_clear_flags(), set_flags :: type_set_flags()) :: t()
  def new(
    %AccountID{} = trustor,
    %Asset{} = asset,
    %Uint32{} = clear_flags,
    %Uint32{} = set_flags
  ),
  do: %__MODULE__{trustor: trustor, asset: asset, clear_flags: clear_flags, set_flags: set_flags}

  @impl true
  def encode_xdr(%__MODULE__{trustor: trustor, asset: asset, clear_flags: clear_flags, set_flags: set_flags}) do
    [trustor: trustor, asset: asset, clear_flags: clear_flags, set_flags: set_flags]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{trustor: trustor, asset: asset, clear_flags: clear_flags, set_flags: set_flags}) do
    [trustor: trustor, asset: asset, clear_flags: clear_flags, set_flags: set_flags]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [trustor: trustor, asset: asset, clear_flags: clear_flags, set_flags: set_flags]}, rest}} ->
        {:ok, {new(trustor, asset, clear_flags, set_flags), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [trustor: trustor, asset: asset, clear_flags: clear_flags, set_flags: set_flags]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)
    {new(trustor, asset, clear_flags, set_flags), rest}
  end
end
