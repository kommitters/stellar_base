defmodule StellarBase.XDR.ContractCodeEntry do
  @moduledoc """
  Representation of Stellar `ContractCodeEntry` type.
  """

  alias StellarBase.XDR.{Hash, VariableOpaque256000, ExtensionPoint}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(
                 hash: Hash,
                 code: VariableOpaque256000,
                 ext: ExtensionPoint
               )

  @type t :: %__MODULE__{
          hash: Hash.t(),
          code: VariableOpaque256000.t(),
          ext: ExtensionPoint.t()
        }

  defstruct [:hash, :code, :ext]

  @spec new(
          hash :: Hash.t(),
          code :: VariableOpaque256000.t(),
          ext :: ExtensionPoint.t()
        ) :: t()
  def new(
        %Hash{} = hash,
        %VariableOpaque256000{} = code,
        %ExtensionPoint{} = ext
      ),
      do: %__MODULE__{hash: hash, code: code, ext: ext}

  @impl true
  def encode_xdr(%__MODULE__{
        hash: hash,
        code: code,
        ext: ext
      }) do
    [hash: hash, code: code, ext: ext]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{
        hash: hash,
        code: code,
        ext: ext
      }) do
    [hash: hash, code: code, ext: ext]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok,
       {%XDR.Struct{
          components: [hash: hash, code: code, ext: ext]
        }, rest}} ->
        {:ok, {new(hash, code, ext), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{
       components: [hash: hash, code: code, ext: ext]
     }, rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(hash, code, ext), rest}
  end
end
