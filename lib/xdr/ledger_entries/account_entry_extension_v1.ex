defmodule StellarBase.XDR.AccountEntryExtensionV1 do
  @moduledoc """
  Representation of Stellar's ledger AccountEntryExtensionV1
  """

  alias StellarBase.XDR.{Liabilities, AccountEntryExtensionV1Ext}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(
                 liabilities: Liabilities,
                 account_entry_extension_v1_ext: AccountEntryExtensionV1Ext
               )

  @type t :: %__MODULE__{
          liabilities: Liabilities.t(),
          account_entry_extension_v1_ext: AccountEntryExtensionV1Ext.t()
        }

  defstruct [:liabilities, :account_entry_extension_v1_ext]

  @spec new(
          liabilities :: Liabilities.t(),
          account_entry_extension_v1_ext :: AccountEntryExtensionV1Ext.t()
        ) :: t()
  def new(
        %Liabilities{} = liabilities,
        %AccountEntryExtensionV1Ext{} = account_entry_extension_v1_ext
      ),
      do: %__MODULE__{
        liabilities: liabilities,
        account_entry_extension_v1_ext: account_entry_extension_v1_ext
      }

  @impl true
  def encode_xdr(%__MODULE__{
        liabilities: liabilities,
        account_entry_extension_v1_ext: account_entry_extension_v1_ext
      }) do
    [liabilities: liabilities, account_entry_extension_v1_ext: account_entry_extension_v1_ext]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{
        liabilities: liabilities,
        account_entry_extension_v1_ext: account_entry_extension_v1_ext
      }) do
    [liabilities: liabilities, account_entry_extension_v1_ext: account_entry_extension_v1_ext]
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
            liabilities: liabilities,
            account_entry_extension_v1_ext: account_entry_extension_v1_ext
          ]
        }, rest}} ->
        {:ok, {new(liabilities, account_entry_extension_v1_ext), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{
       components: [
         liabilities: liabilities,
         account_entry_extension_v1_ext: account_entry_extension_v1_ext
       ]
     }, rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(liabilities, account_entry_extension_v1_ext), rest}
  end
end
