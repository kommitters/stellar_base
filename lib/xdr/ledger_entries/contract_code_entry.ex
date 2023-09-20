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
    VariableOpaque
  }

  @struct_spec XDR.Struct.new(
                 ext: ExtensionPoint,
                 hash: Hash,
                 code: VariableOpaque
               )

  @type ext_type :: ExtensionPoint.t()
  @type hash_type :: Hash.t()
  @type code_type :: VariableOpaque.t()

  @type t :: %__MODULE__{
          ext: ext_type(),
          hash: hash_type(),
          code: code_type()
        }

  defstruct [:ext, :hash, :code]

  @spec new(
          ext :: ext_type(),
          hash :: hash_type(),
          code :: code_type()
        ) :: t()
  def new(
        %ExtensionPoint{} = ext,
        %Hash{} = hash,
        %VariableOpaque{} = code
      ),
      do: %__MODULE__{
        ext: ext,
        hash: hash,
        code: code
      }

  @impl true
  def encode_xdr(%__MODULE__{
        ext: ext,
        hash: hash,
        code: code
      }) do
    [ext: ext, hash: hash, code: code]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{
        ext: ext,
        hash: hash,
        code: code
      }) do
    [ext: ext, hash: hash, code: code]
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
            code: code
          ]
        }, rest}} ->
        {:ok, {new(ext, hash, code), rest}}

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
         code: code
       ]
     }, rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(ext, hash, code), rest}
  end
end
