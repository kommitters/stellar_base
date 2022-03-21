defmodule StellarBase.XDR.LedgerEntryExtensionV1 do
  @moduledoc """
  Representation of Stellar's ledger LedgerEntryExtensionV1
  """

  alias StellarBase.XDR.{SponsorshipDescriptor, Ext}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(
                 sponsoring_id: SponsorshipDescriptor,
                 ext: Ext
               )

  @type t :: %__MODULE__{
          sponsoring_id: SponsorshipDescriptor.t(),
          ext: Ext.t()
        }

  defstruct [:sponsoring_id, :ext]

  @spec new(
          sponsoring_id :: SponsorshipDescriptor.t(),
          ext :: Ext.t()
        ) :: t()
  def new(
        %SponsorshipDescriptor{} = sponsoring_id,
        %Ext{} = ext
      ),
      do: %__MODULE__{
        sponsoring_id: sponsoring_id,
        ext: ext
      }

  @impl true
  def encode_xdr(%__MODULE__{
        sponsoring_id: sponsoring_id,
        ext: ext
      }) do
    [
      sponsoring_id: sponsoring_id,
      ext: ext
    ]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{
        sponsoring_id: sponsoring_id,
        ext: ext
      }) do
    [
      sponsoring_id: sponsoring_id,
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
            sponsoring_id: sponsoring_id,
            ext: ext
          ]
        }, rest}} ->
        {:ok, {new(sponsoring_id, ext), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{
       components: [
         sponsoring_id: sponsoring_id,
         ext: ext
       ]
     }, rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(sponsoring_id, ext), rest}
  end
end
