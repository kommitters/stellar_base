defmodule StellarBase.XDR.AccountEntryExtensionV1 do
  @moduledoc """
  Representation of Stellar's ledger AccountEntryExtensionV1
  """

  alias StellarBase.XDR.{Liabilities}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(liabilities: Liabilities)

  @type t :: %__MODULE__{
          liabilities: Liabilities.t()
        }

  defstruct [:liabilities]

  @spec new(liabilities :: Liabilities.t()) :: t()
  def new(%Liabilities{} = liabilities),
    do: %__MODULE__{liabilities: liabilities}

  @impl true
  def encode_xdr(%__MODULE__{liabilities: liabilities}) do
    [liabilities: liabilities]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{liabilities: liabilities}) do
    [liabilities: liabilities]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok,
       {%XDR.Struct{
          components: [liabilities: liabilities]
        }, rest}} ->
        {:ok, {new(liabilities), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{
       components: [liabilities: liabilities]
     }, rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(liabilities), rest}
  end
end
