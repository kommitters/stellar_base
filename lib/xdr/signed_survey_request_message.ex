defmodule StellarBase.XDR.SignedSurveyRequestMessage do
  @moduledoc """
  Automatically generated by xdrgen
  DO NOT EDIT or your changes may be overwritten

  Target implementation: elixir_xdr at https://hex.pm/packages/elixir_xdr

  Representation of Stellar `SignedSurveyRequestMessage` type.
  """

  @behaviour XDR.Declaration

  alias StellarBase.XDR.{
    Signature,
    SurveyRequestMessage
  }

  @struct_spec XDR.Struct.new(
    request_signature: Signature,
    request: SurveyRequestMessage
  )

  @type type_request_signature :: Signature.t()
  @type type_request :: SurveyRequestMessage.t()

  @type t :: %__MODULE__{request_signature: type_request_signature(), request: type_request()}

  defstruct [:request_signature, :request]

  @spec new(request_signature :: type_request_signature(), request :: type_request()) :: t()
  def new(
    %Signature{} = request_signature,
    %SurveyRequestMessage{} = request
  ),
  do: %__MODULE__{request_signature: request_signature, request: request}

  @impl true
  def encode_xdr(%__MODULE__{request_signature: request_signature, request: request}) do
    [request_signature: request_signature, request: request]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{request_signature: request_signature, request: request}) do
    [request_signature: request_signature, request: request]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [request_signature: request_signature, request: request]}, rest}} ->
        {:ok, {new(request_signature, request), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [request_signature: request_signature, request: request]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)
    {new(request_signature, request), rest}
  end
end
