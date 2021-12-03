defmodule StellarBase.XDR.Operation do
  @moduledoc """
  Representation of Stellar `Operation` type.
  """
  alias StellarBase.XDR.{OptionalMuxedAccount, OperationBody}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(body: OperationBody, source_account: OptionalMuxedAccount)

  @type t :: %__MODULE__{body: OperationBody.t(), source_account: OptionalMuxedAccount.t()}

  defstruct [:source_account, :body]

  @spec new(operation_body :: OperationBody.t(), source_account :: OptionalMuxedAccount.t()) ::
          t()
  def new(%OperationBody{} = body, %OptionalMuxedAccount{} = source_account) do
    %__MODULE__{body: body, source_account: source_account}
  end

  @impl true
  def encode_xdr(%__MODULE__{body: body, source_account: source_account}) do
    [body: body, source_account: source_account]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{body: body, source_account: source_account}) do
    [body: body, source_account: source_account]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [body: body, source_account: source_account]}, rest}} ->
        {:ok, {new(body, source_account), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [body: body, source_account: source_account]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(body, source_account), rest}
  end
end
