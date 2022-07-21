defmodule StellarBase.XDR.AccountEntryExtensionV3 do
  @moduledoc """
  Representation of Stellar's ledger AccountEntryExtensionV3
  """
  alias StellarBase.XDR.{ExtensionPoint, UInt32, TimePoint}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(
                 ext: ExtensionPoint,
                 seq_ledger: UInt32,
                 seq_time: TimePoint
               )

  @type t :: %__MODULE__{
          ext: ExtensionPoint.t(),
          seq_ledger: UInt32.t(),
          seq_time: TimePoint.t()
        }

  defstruct [:ext, :seq_ledger, :seq_time]

  @spec new(
          ext :: ExtensionPoint.t(),
          seq_ledger :: UInt32.t(),
          seq_time :: TimePoint.t()
        ) :: t()
  def new(
        %ExtensionPoint{} = ext,
        %UInt32{} = seq_ledger,
        %TimePoint{} = seq_time
      ),
      do: %__MODULE__{
        ext: ext,
        seq_ledger: seq_ledger,
        seq_time: seq_time
      }

  @impl true
  def encode_xdr(%__MODULE__{
        ext: ext,
        seq_ledger: seq_ledger,
        seq_time: seq_time
      }) do
    [
      ext: ext,
      seq_ledger: seq_ledger,
      seq_time: seq_time
    ]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{
        ext: ext,
        seq_ledger: seq_ledger,
        seq_time: seq_time
      }) do
    [
      ext: ext,
      seq_ledger: seq_ledger,
      seq_time: seq_time
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
            ext: ext,
            seq_ledger: seq_ledger,
            seq_time: seq_time
          ]
        }, rest}} ->
        {:ok, {new(ext, seq_ledger, seq_time), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{
       components: [
         ext: ext,
         seq_ledger: seq_ledger,
         seq_time: seq_time
       ]
     }, rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(ext, seq_ledger, seq_time), rest}
  end
end
