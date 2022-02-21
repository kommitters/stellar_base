defmodule StellarBase.XDR.TrustLineEntry do
  @moduledoc """
  Representation of Stellar `TrustLineEntry` type.
  """
  alias StellarBase.XDR.{AccountID, TrustLineAsset, Int64, UInt32, TrustLineEntryExt}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(
                 account_id: AccountID,
                 asset: TrustLineAsset,
                 balance: Int64,
                 limit: Int64,
                 flags: UInt32,
                 trust_line_entry_ext: TrustLineEntryExt
               )

  @type t :: %__MODULE__{
          account_id: AccountID.t(),
          asset: TrustLineAsset.t(),
          balance: Int64.t(),
          limit: Int64.t(),
          flags: UInt32.t(),
          trust_line_entry_ext: TrustLineEntryExt.t()
        }

  defstruct [
    :account_id,
    :asset,
    :balance,
    :limit,
    :flags,
    :trust_line_entry_ext
  ]

  @spec new(
          account_id :: AccountID.t(),
          asset :: TrustLineAsset.t(),
          balance :: Int64.t(),
          limit :: Int64.t(),
          flags :: UInt32.t(),
          trust_line_entry_ext :: TrustLineEntryExt.t()
        ) :: t()
  def new(
        %AccountID{} = account_id,
        %TrustLineAsset{} = asset,
        %Int64{} = balance,
        %Int64{} = limit,
        %UInt32{} = flags,
        %TrustLineEntryExt{} = trust_line_entry_ext
      ),
      do: %__MODULE__{
        account_id: account_id,
        asset: asset,
        balance: balance,
        limit: limit,
        flags: flags,
        trust_line_entry_ext: trust_line_entry_ext
      }

  @impl true
  def encode_xdr(%__MODULE__{
        account_id: account_id,
        asset: asset,
        balance: balance,
        limit: limit,
        flags: flags,
        trust_line_entry_ext: trust_line_entry_ext
      }) do
    [
      account_id: account_id,
      asset: asset,
      balance: balance,
      limit: limit,
      flags: flags,
      trust_line_entry_ext: trust_line_entry_ext
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
        trust_line_entry_ext: trust_line_entry_ext
      }) do
    [
      account_id: account_id,
      asset: asset,
      balance: balance,
      limit: limit,
      flags: flags,
      trust_line_entry_ext: trust_line_entry_ext
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
            trust_line_entry_ext: trust_line_entry_ext
          ]
        }, rest}} ->
        {:ok, {new(account_id, asset, balance, limit, flags, trust_line_entry_ext), rest}}

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
         trust_line_entry_ext: trust_line_entry_ext
       ]
     }, rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(account_id, asset, balance, limit, flags, trust_line_entry_ext), rest}
  end
end
