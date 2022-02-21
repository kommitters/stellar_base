defmodule StellarBase.XDR.TrustLineEntryExtV1 do
  @moduledoc """
  Representation of Stellar `TrustLineEntryExtV1` type.
  """
  alias StellarBase.XDR.{Liabilities, TrustLineEntryExtV1Ext}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(
                 liabilities: Liabilities,
                 trust_line_entry_ext_v1_ext: TrustLineEntryExtV1Ext
               )

  defstruct [:liabilities, :trust_line_entry_ext_v1_ext]

  @type t :: %__MODULE__{
          liabilities: Liabilities.t(),
          trust_line_entry_ext_v1_ext: TrustLineEntryExtV1Ext.t()
        }

  @spec new(
          liabilities :: Liabilities.t(),
          trust_line_entry_ext_v1_ext :: TrustLineEntryExtV1Ext.t()
        ) :: t()
  def new(%Liabilities{} = liabilities, %TrustLineEntryExtV1Ext{} = trust_line_entry_ext_v1_ext),
    do: %__MODULE__{
      liabilities: liabilities,
      trust_line_entry_ext_v1_ext: trust_line_entry_ext_v1_ext
    }

  @impl true
  def encode_xdr(%__MODULE__{
        liabilities: liabilities,
        trust_line_entry_ext_v1_ext: trust_line_entry_ext_v1_ext
      }) do
    [liabilities: liabilities, trust_line_entry_ext_v1_ext: trust_line_entry_ext_v1_ext]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{
        liabilities: liabilities,
        trust_line_entry_ext_v1_ext: trust_line_entry_ext_v1_ext
      }) do
    [liabilities: liabilities, trust_line_entry_ext_v1_ext: trust_line_entry_ext_v1_ext]
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
            trust_line_entry_ext_v1_ext: trust_line_entry_ext_v1_ext
          ]
        }, rest}} ->
        {:ok, {new(liabilities, trust_line_entry_ext_v1_ext), rest}}

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
         trust_line_entry_ext_v1_ext: trust_line_entry_ext_v1_ext
       ]
     }, rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(liabilities, trust_line_entry_ext_v1_ext), rest}
  end
end
