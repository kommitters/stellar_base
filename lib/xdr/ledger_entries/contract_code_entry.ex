defmodule StellarBase.XDR.ContractCodeEntry do
  @moduledoc """
  Automatically generated by xdrgen
  DO NOT EDIT or your changes may be overwritten

  Target implementation: elixir_xdr at https://hex.pm/packages/elixir_xdr

  Representation of Stellar `ContractCodeEntry` type.
  """

  @behaviour XDR.Declaration

  alias StellarBase.XDR.{
    ExtensionPoint,
    Hash,
    ContractCodeEntryBody,
    UInt32
  }

  @struct_spec XDR.Struct.new(
                 ext: ExtensionPoint,
                 hash: Hash,
                 body: ContractCodeEntryBody,
                 expiration_ledger_seq: UInt32
               )

  @type ext_type :: ExtensionPoint.t()
  @type hash_type :: Hash.t()
  @type body_type :: ContractCodeEntryBody.t()
  @type expiration_ledger_seq_type :: UInt32.t()

  @type t :: %__MODULE__{
          ext: ext_type(),
          hash: hash_type(),
          body: body_type(),
          expiration_ledger_seq: expiration_ledger_seq_type()
        }

  defstruct [:ext, :hash, :body, :expiration_ledger_seq]

  @spec new(
          ext :: ext_type(),
          hash :: hash_type(),
          body :: body_type(),
          expiration_ledger_seq :: expiration_ledger_seq_type()
        ) :: t()
  def new(
        %ExtensionPoint{} = ext,
        %Hash{} = hash,
        %ContractCodeEntryBody{} = body,
        %UInt32{} = expiration_ledger_seq
      ),
      do: %__MODULE__{
        ext: ext,
        hash: hash,
        body: body,
        expiration_ledger_seq: expiration_ledger_seq
      }

  @impl true
  def encode_xdr(%__MODULE__{
        ext: ext,
        hash: hash,
        body: body,
        expiration_ledger_seq: expiration_ledger_seq
      }) do
    [ext: ext, hash: hash, body: body, expiration_ledger_seq: expiration_ledger_seq]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{
        ext: ext,
        hash: hash,
        body: body,
        expiration_ledger_seq: expiration_ledger_seq
      }) do
    [ext: ext, hash: hash, body: body, expiration_ledger_seq: expiration_ledger_seq]
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
            hash: hash,
            body: body,
            expiration_ledger_seq: expiration_ledger_seq
          ]
        }, rest}} ->
        {:ok, {new(ext, hash, body, expiration_ledger_seq), rest}}

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
         hash: hash,
         body: body,
         expiration_ledger_seq: expiration_ledger_seq
       ]
     }, rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(ext, hash, body, expiration_ledger_seq), rest}
  end
end
