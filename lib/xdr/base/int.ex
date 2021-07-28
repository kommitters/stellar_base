defmodule Stellar.XDR.Int32 do
  @moduledoc """
  Representation of Stellar `Int32` type.
  """
  @behaviour XDR.Declaration

  @type t :: %__MODULE__{datum: integer()}

  defstruct [:datum]

  @spec new(int32 :: integer()) :: t()
  def new(int32), do: %__MODULE__{datum: int32}

  @impl true
  def encode_xdr(%__MODULE__{datum: int32}) do
    XDR.Int.encode_xdr(%XDR.Int{datum: int32})
  end

  @impl true
  def encode_xdr!(%__MODULE__{datum: int32}) do
    XDR.Int.encode_xdr!(%XDR.Int{datum: int32})
  end

  @impl true
  def decode_xdr(bytes, term \\ nil)

  def decode_xdr(bytes, _term) do
    case XDR.Int.decode_xdr(bytes) do
      {:ok, {%XDR.Int{datum: int32}, rest}} -> {:ok, {new(int32), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, term \\ nil)

  def decode_xdr!(bytes, _term) do
    {%XDR.Int{datum: int32}, rest} = XDR.Int.decode_xdr!(bytes)
    {new(int32), rest}
  end
end

defmodule Stellar.XDR.Int64 do
  @moduledoc """
  Representation of Stellar `Int64` type.
  """
  @behaviour XDR.Declaration

  @type t :: %__MODULE__{datum: integer()}

  defstruct [:datum]

  @spec new(int64 :: integer()) :: t()
  def new(int64), do: %__MODULE__{datum: int64}

  @impl true
  def encode_xdr(%__MODULE__{datum: int64}) do
    XDR.HyperInt.encode_xdr(%XDR.HyperInt{datum: int64})
  end

  @impl true
  def encode_xdr!(%__MODULE__{datum: int64}) do
    XDR.HyperInt.encode_xdr!(%XDR.HyperInt{datum: int64})
  end

  @impl true
  def decode_xdr(bytes, term \\ nil)

  def decode_xdr(bytes, _term) do
    case XDR.HyperInt.decode_xdr(bytes) do
      {:ok, {%XDR.HyperInt{datum: int64}, rest}} -> {:ok, {new(int64), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, term \\ nil)

  def decode_xdr!(bytes, _term) do
    {%XDR.HyperInt{datum: int64}, rest} = XDR.HyperInt.decode_xdr!(bytes)
    {new(int64), rest}
  end
end
