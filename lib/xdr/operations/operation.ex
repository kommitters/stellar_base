defmodule StellarBase.XDR.Operation do
  @moduledoc """
  Representation of Stellar `Operation` type.
  """
  alias StellarBase.XDR.{OptionalMuxedAccount, OperationBody}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(source_account: OptionalMuxedAccount, body: OperationBody)

  @type t :: %__MODULE__{source_account: OptionalMuxedAccount.t(), body: OperationBody.t()}

  defstruct [:source_account, :body]

  @spec new(source_account :: OptionalMuxedAccount.t(), operation_body :: OperationBody.t()) ::
          t()
  def new(%OptionalMuxedAccount{} = source_account, %OperationBody{} = body) do
    %__MODULE__{source_account: source_account, body: body}
  end

  @impl true
  def encode_xdr(%__MODULE__{source_account: source_account, body: body}) do
    [source_account: source_account, body: body]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{source_account: source_account, body: body}) do
    [source_account: source_account, body: body]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [source_account: source_account, body: body]}, rest}} ->
        {:ok, {new(source_account, body), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [source_account: source_account, body: body]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(source_account, body), rest}
  end
end
