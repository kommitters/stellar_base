defmodule StellarBase.XDR.SCSpecFunctionV0 do
  @moduledoc """
  Representation of Stellar `SCSpecFunctionV0` type.
  """

  alias StellarBase.XDR.{SCSpecTypeDef1, String1024, SCSymbol, SCSpecFunctionInputV0List}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(
                 doc: String1024,
                 name: SCSymbol,
                 inputs: SCSpecFunctionInputV0List,
                 outputs: SCSpecTypeDef1
               )

  @type doc :: String1024.t()
  @type name :: SCSymbol.t()
  @type inputs :: SCSpecFunctionInputV0List.t()
  @type outputs :: SCSpecTypeDef1.t()

  @type t :: %__MODULE__{
          doc: doc(),
          name: name(),
          inputs: inputs(),
          outputs: outputs()
        }

  defstruct [:doc, :name, :inputs, :outputs]

  @spec new(doc :: doc(), name :: name(), inputs :: inputs(), outputs: outputs()) :: t()
  @spec new(
          StellarBase.XDR.String1024.t(),
          StellarBase.XDR.SCSymbol.t(),
          StellarBase.XDR.SCSpecFunctionInputV0List.t(),
          StellarBase.XDR.SCSpecTypeDef1.t()
        ) :: StellarBase.XDR.SCSpecFunctionV0.t()
  def new(
        %String1024{} = doc,
        %SCSymbol{} = name,
        %SCSpecFunctionInputV0List{} = inputs,
        %SCSpecTypeDef1{} = outputs
      ),
      do: %__MODULE__{doc: doc, name: name, inputs: inputs, outputs: outputs}

  @impl true
  def encode_xdr(%__MODULE__{doc: doc, name: name, inputs: inputs, outputs: outputs}) do
    [doc: doc, name: name, inputs: inputs, outputs: outputs]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{doc: doc, name: name, inputs: inputs, outputs: outputs}) do
    [doc: doc, name: name, inputs: inputs, outputs: outputs]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok,
       {%XDR.Struct{components: [doc: doc, name: name, inputs: inputs, outputs: outputs]}, rest}} ->
        {:ok, {new(doc, name, inputs, outputs), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [doc: doc, name: name, inputs: inputs, outputs: outputs]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(doc, name, inputs, outputs), rest}
  end
end
