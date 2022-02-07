defmodule StellarBase.XDR.TrustLineEntry do
  @moduledoc """
  Representation of Stellar `TrustLineEntry` type.
  """
  alias StellarBase.XDR.{AccountID, TrustLineAsset, Int64, UInt32, Ext}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(
                 account_id: AccountID,
                 asset: TrustLineAsset,
                 balance: Int64,
                 limit: Int64,
                 flags: UInt32,
                 ext: Ext
               )

  @type t :: %__MODULE__{
          account_id: AccountID.t(),
          asset: TrustLineAsset.t(),
          balance: Int64.t(),
          limit: Int64.t(),
          flags: UInt32.t(),
          ext: Ext.t()
        }

  defstruct [
    :account_id,
    :asset,
    :balance,
    :limit,
    :flags,
    :ext
  ]

  @spec new(
          account_id :: AccountID.t(),
          asset :: TrustLineAsset.t(),
          balance :: Int64.t(),
          limit :: Int64.t(),
          flags :: UInt32.t(),
          ext :: Ext.t()
        ) :: t()
  def new(
        %AccountID{} = account_id,
        %TrustLineAsset{} = asset,
        %Int64{} = balance,
        %Int64{} = limit,
        %UInt32{} = flags,
        %Ext{} = ext
      ),
      do: %__MODULE__{
        account_id: account_id,
        asset: asset,
        balance: balance,
        limit: limit,
        flags: flags,
        ext: ext
      }

  @impl true
  def encode_xdr(%__MODULE__{
        account_id: account_id,
        asset: asset,
        balance: balance,
        limit: limit,
        flags: flags,
        ext: ext
      }) do
    [
      account_id: account_id,
      asset: asset,
      balance: balance,
      limit: limit,
      flags: flags,
      ext: ext
    ]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{
        account_id: account_id,
        asset: asset,
        balance: balance,
        limit: limit,
        flags: flags,
        ext: ext
      }) do
    [
      account_id: account_id,
      asset: asset,
      balance: balance,
      limit: limit,
      flags: flags,
      ext: ext
    ]
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
            account_id: account_id,
            asset: asset,
            balance: balance,
            limit: limit,
            flags: flags,
            ext: ext
          ]
        }, rest}} ->
        {:ok, {new(account_id, asset, balance, limit, flags, ext), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{
       components: [
         account_id: account_id,
         asset: asset,
         balance: balance,
         limit: limit,
         flags: flags,
         ext: ext
       ]
     }, rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(account_id, asset, balance, limit, flags, ext), rest}
  end
end
