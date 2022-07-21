defmodule StellarBase.XDR.AccountEntry do
  @moduledoc """
  Representation of Stellar's ledger AccountEntry
  """

  alias StellarBase.XDR.{AccountID, Int64, SequenceNumber, UInt32, String32, Thresholds, Signer}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(
                 account_id: AccountID,
                 balance: Int64,
                 seq_num: SequenceNumber,
                 num_sub_entries: UInt32,
                 inflation_dest: AccountID,
                 flags: UInt32,
                 home_domain: String32,
                 thresholds: Thresholds,
                 signers: Signer
               )

  @type t :: %__MODULE__{
          account_id: AccountID.t(),
          balance: Int64.t(),
          seq_num: SequenceNumber.t(),
          num_sub_entries: UInt32.t(),
          inflation_dest: AccountID.t(),
          flags: UInt32.t(),
          home_domain: String32.t(),
          thresholds: Thresholds.t(),
          signers: Signer.t()
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
    :signers
  ]

  @spec new(
          account_id :: AccountID.t(),
          balance :: Int64.t(),
          seq_num :: SequenceNumber.t(),
          num_sub_entries :: UInt32.t(),
          inflation_dest :: AccountID.t(),
          flags :: UInt32.t(),
          home_domain :: String32.t(),
          thresholds :: Thresholds.t(),
          signers :: Signer.t()
        ) :: t()
  def new(
        %AccountID{} = account_id,
        %Int64{} = balance,
        %SequenceNumber{} = seq_num,
        %UInt32{} = num_sub_entries,
        %AccountID{} = inflation_dest,
        %UInt32{} = flags,
        %String32{} = home_domain,
        %Thresholds{} = thresholds,
        %Signer{} = signers
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
        signers: signers
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
        signers: signers
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
      signers: signers
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
        signers: signers
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
      signers: signers
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
            signers: signers
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
            signers
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
         signers: signers
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
       signers
     ), rest}
  end
end
