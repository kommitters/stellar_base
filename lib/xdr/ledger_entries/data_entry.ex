defmodule StellarBase.XDR.DataEntry do
  @moduledoc """
  Representation of Stellar `DataEntry` type.
  """
  alias StellarBase.XDR.{AccountID, String64, DataValue, Ext}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(
                 account_id: AccountID,
                 data_name: String64,
                 data_value: DataValue,
                 ext: Ext
               )

  @type t :: %__MODULE__{
          account_id: AccountID.t(),
          data_name: String64.t(),
          data_value: DataValue.t(),
          ext: Ext.t()
        }

  defstruct [:account_id, :data_name, :data_value, :ext]

  @spec new(
          account_id :: AccountID.t(),
          data_name :: String64.t(),
          data_value :: DataValue.t(),
          ext :: Ext.t()
        ) :: t()
  def new(
        %AccountID{} = account_id,
        %String64{} = data_name,
        %DataValue{} = data_value,
        %Ext{} = ext
      ),
      do: %__MODULE__{
        account_id: account_id,
        data_name: data_name,
        data_value: data_value,
        ext: ext
      }

  @impl true
  def encode_xdr(%__MODULE__{
        account_id: account_id,
        data_name: data_name,
        data_value: data_value,
        ext: ext
      }) do
    [account_id: account_id, data_name: data_name, data_value: data_value, ext: ext]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{
        account_id: account_id,
        data_name: data_name,
        data_value: data_value,
        ext: ext
      }) do
    [account_id: account_id, data_name: data_name, data_value: data_value, ext: ext]
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
            data_name: data_name,
            data_value: data_value,
            ext: ext
          ]
        }, rest}} ->
        {:ok, {new(account_id, data_name, data_value, ext), rest}}

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
         data_name: data_name,
         data_value: data_value,
         ext: ext
       ]
     }, rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(account_id, data_name, data_value, ext), rest}
  end
end
