defmodule StellarBase.XDR.AuthorizedInvocationList do
  @moduledoc """
  Representation of a Stellar `AuthorizedInvocationList` list.
  """
  alias StellarBase.XDR.AuthorizedInvocation

  @behaviour XDR.Declaration

  @max_length 4_294_967_295

  @array_type AuthorizedInvocation

  @array_spec %{type: @array_type, max_length: @max_length}

  @type t :: %__MODULE__{sub_invocations: list(AuthorizedInvocation.t())}

  defstruct [:sub_invocations]

  @spec new(sub_invocations :: list(AuthorizedInvocation.t())) :: t()
  def new(sub_invocations \\ []), do: %__MODULE__{sub_invocations: sub_invocations}

  @impl true
  def encode_xdr(%__MODULE__{sub_invocations: sub_invocations}) do
    sub_invocations
    |> XDR.VariableArray.new(@array_type, @max_length)
    |> XDR.VariableArray.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{sub_invocations: sub_invocations}) do
    sub_invocations
    |> XDR.VariableArray.new(@array_type, @max_length)
    |> XDR.VariableArray.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ @array_spec)

  def decode_xdr(bytes, spec) do
    case XDR.VariableArray.decode_xdr(bytes, spec) do
      {:ok, {sub_invocations, rest}} -> {:ok, {new(sub_invocations), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ @array_spec)

  def decode_xdr!(bytes, spec) do
    {sub_invocations, rest} = XDR.VariableArray.decode_xdr!(bytes, spec)
    {new(sub_invocations), rest}
  end
end
