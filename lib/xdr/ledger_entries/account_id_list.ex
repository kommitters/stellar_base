defmodule StellarBase.XDR.AccountIDList do
  @moduledoc """
  Representation of a Stellar `AccountID` list.
  """

  alias StellarBase.XDR.AccountID

  @behaviour XDR.Declaration

  @max_length 20

  @array_type AccountID

  @array_spec %{type: @array_type, max_lengtha: @max_length}

  @type t :: %__MODULE__{account_ids: list(AccountID.t())}

  defstruct [:account_ids]

  @spec new(account_ids :: list(AccountID.t())) :: t()
  def new(account_ids), do: %__MODULE__{account_ids: account_ids}

  @impl true
  def encode_xdr(%__MODULE__{account_ids: account_ids}) do
    account_ids
    |> XDR.VariableArray.new(@array_type, @max_length)
    |> XDR.VariableArray.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{account_ids: account_ids}) do
    account_ids
    |> XDR.VariableArray.new(@array_type, @max_length)
    |> XDR.VariableArray.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ @array_spec)

  def decode_xdr(bytes, spec) do
    case XDR.VariableArray.decode_xdr(bytes, spec) do
      {:ok, {account_ids, rest}} -> {:ok, {new(account_ids), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ @array_spec)

  def decode_xdr!(bytes, spec) do
    {account_ids, rest} = XDR.VariableArray.decode_xdr!(bytes, spec)
    {new(account_ids), rest}
  end
end
