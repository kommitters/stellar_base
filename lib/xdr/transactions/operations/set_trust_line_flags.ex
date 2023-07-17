defmodule StellarBase.XDR.SetTrustLineFlags do
  @moduledoc """
  Representation of Stellar `SetTrustLineFlags` type.
  """
  alias StellarBase.XDR.{AccountID, Asset, UInt32}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(
                 trustor: AccountID,
                 asset: Asset,
                 clear_flags: UInt32,
                 set_flags: UInt32
               )

  @type t :: %__MODULE__{
          trustor: AccountID.t(),
          asset: Asset.t(),
          clear_flags: UInt32.t(),
          set_flags: UInt32.t()
        }

  defstruct [:trustor, :asset, :clear_flags, :set_flags]

  @spec new(
          trustor :: AccountID.t(),
          asset :: Asset.t(),
          clear_flags :: UInt32.t(),
          set_flags :: UInt32.t()
        ) :: t()
  def new(
        %AccountID{} = trustor,
        %Asset{} = asset,
        %UInt32{} = clear_flags,
        %UInt32{} = set_flags
      ),
      do: %__MODULE__{
        trustor: trustor,
        asset: asset,
        clear_flags: clear_flags,
        set_flags: set_flags
      }

  @impl true
  def encode_xdr(%__MODULE__{
        trustor: trustor,
        asset: asset,
        clear_flags: clear_flags,
        set_flags: set_flags
      }) do
    [trustor: trustor, asset: asset, clear_flags: clear_flags, set_flags: set_flags]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{
        trustor: trustor,
        asset: asset,
        clear_flags: clear_flags,
        set_flags: set_flags
      }) do
    [trustor: trustor, asset: asset, clear_flags: clear_flags, set_flags: set_flags]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok,
       {%XDR.Struct{
          components: [
            trustor: trustor,
            asset: asset,
            clear_flags: clear_flags,
            set_flags: set_flags
          ]
        }, rest}} ->
        {:ok, {new(trustor, asset, clear_flags, set_flags), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{
       components: [
         trustor: trustor,
         asset: asset,
         clear_flags: clear_flags,
         set_flags: set_flags
       ]
     }, rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(trustor, asset, clear_flags, set_flags), rest}
  end
end
