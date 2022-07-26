defmodule StellarBase.XDR.AccountEntry do
  @moduledoc """
  Representation of Stellar's ledger AccountEntry
  """

  alias StellarBase.XDR.{
    AccountID,
    Int64,
    SequenceNumber,
    UInt32,
    OptionalAccountID,
    String32,
    Thresholds,
    Signers,
    AccountEntryExt
  }

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(
                 account_id: AccountID,
                 balance: Int64,
                 seq_num: SequenceNumber,
                 num_sub_entries: UInt32,
                 inflation_dest: OptionalAccountID,
                 flags: UInt32,
                 home_domain: String32,
                 thresholds: Thresholds,
                 signers: Signers,
                 account_entry_ext: AccountEntryExt
               )

  @type t :: %__MODULE__{
          account_id: AccountID.t(),
          balance: Int64.t(),
          seq_num: SequenceNumber.t(),
          num_sub_entries: UInt32.t(),
          inflation_dest: OptionalAccountID.t(),
          flags: UInt32.t(),
          home_domain: String32.t(),
          thresholds: Thresholds.t(),
          signers: Signers.t(),
          account_entry_ext: AccountEntryExt.t()
        }

  defstruct [
    :account_id,
    :balance,
    :seq_num,
    :num_sub_entries,
    :inflation_dest,
    :flags,
    :home_domain,
    :thresholds,
    :signers,
    :account_entry_ext
  ]

  @spec new(
          account_id :: AccountID.t(),
          balance :: Int64.t(),
          seq_num :: SequenceNumber.t(),
          num_sub_entries :: UInt32.t(),
          inflation_dest :: OptionalAccountID.t(),
          flags :: UInt32.t(),
          home_domain :: String32.t(),
          thresholds :: Thresholds.t(),
          signers :: Signers.t(),
          account_entry_ext :: AccountEntryExt.t()
        ) :: t()
  def new(
        %AccountID{} = account_id,
        %Int64{} = balance,
        %SequenceNumber{} = seq_num,
        %UInt32{} = num_sub_entries,
        %OptionalAccountID{} = inflation_dest,
        %UInt32{} = flags,
        %String32{} = home_domain,
        %Thresholds{} = thresholds,
        %Signers{} = signers,
        %AccountEntryExt{} = account_entry_ext
      ),
      do: %__MODULE__{
        account_id: account_id,
        balance: balance,
        seq_num: seq_num,
        num_sub_entries: num_sub_entries,
        inflation_dest: inflation_dest,
        flags: flags,
        home_domain: home_domain,
        thresholds: thresholds,
        signers: signers,
        account_entry_ext: account_entry_ext
      }

  @impl true
  def encode_xdr(%__MODULE__{
        account_id: account_id,
        balance: balance,
        seq_num: seq_num,
        num_sub_entries: num_sub_entries,
        inflation_dest: inflation_dest,
        flags: flags,
        home_domain: home_domain,
        thresholds: thresholds,
        signers: signers,
        account_entry_ext: account_entry_ext
      }) do
    [
      account_id: account_id,
      balance: balance,
      seq_num: seq_num,
      num_sub_entries: num_sub_entries,
      inflation_dest: inflation_dest,
      flags: flags,
      home_domain: home_domain,
      thresholds: thresholds,
      signers: signers,
      account_entry_ext: account_entry_ext
    ]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{
        account_id: account_id,
        balance: balance,
        seq_num: seq_num,
        num_sub_entries: num_sub_entries,
        inflation_dest: inflation_dest,
        flags: flags,
        home_domain: home_domain,
        thresholds: thresholds,
        signers: signers,
        account_entry_ext: account_entry_ext
      }) do
    [
      account_id: account_id,
      balance: balance,
      seq_num: seq_num,
      num_sub_entries: num_sub_entries,
      inflation_dest: inflation_dest,
      flags: flags,
      home_domain: home_domain,
      thresholds: thresholds,
      signers: signers,
      account_entry_ext: account_entry_ext
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
            balance: balance,
            seq_num: seq_num,
            num_sub_entries: num_sub_entries,
            inflation_dest: inflation_dest,
            flags: flags,
            home_domain: home_domain,
            thresholds: thresholds,
            signers: signers,
            account_entry_ext: account_entry_ext
          ]
        }, rest}} ->
        {:ok,
         {new(
            account_id,
            balance,
            seq_num,
            num_sub_entries,
            inflation_dest,
            flags,
            home_domain,
            thresholds,
            signers,
            account_entry_ext
          ), rest}}

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
         balance: balance,
         seq_num: seq_num,
         num_sub_entries: num_sub_entries,
         inflation_dest: inflation_dest,
         flags: flags,
         home_domain: home_domain,
         thresholds: thresholds,
         signers: signers,
         account_entry_ext: account_entry_ext
       ]
     }, rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(
       account_id,
       balance,
       seq_num,
       num_sub_entries,
       inflation_dest,
       flags,
       home_domain,
       thresholds,
       signers,
       account_entry_ext
     ), rest}
  end
end
