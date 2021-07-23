defmodule Stellar.XDR.UInt32 do
  @moduledoc """
  Representation of Stellar `UInt32` type.
  """
  @behaviour XDR.Declaration

  defstruct [:datum]

  @type t :: %__MODULE__{datum: non_neg_integer()}

  @spec new(uint32 :: non_neg_integer()) :: t()
  def new(uint32), do: %__MODULE__{datum: uint32}

  @impl true
  def encode_xdr(uint32) do
    uint32
    |> XDR.UInt.new()
    |> XDR.UInt.encode_xdr()
  end

  @impl true
  def encode_xdr!(uint32) do
    uint32
    |> XDR.UInt.new()
    |> XDR.UInt.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, term \\ nil)

  def decode_xdr(bytes, _term) do
    case XDR.UInt.decode_xdr(bytes) do
      {:ok, {%XDR.UInt{datum: uint32}, rest}} -> {:ok, {new(uint32), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, term \\ nil)

  def decode_xdr!(bytes, _term) do
    {%XDR.UInt{datum: uint32}, rest} = XDR.UInt.decode_xdr!(bytes)
    {new(uint32), rest}
  end
end

defmodule Stellar.XDR.UInt64 do
  @moduledoc """
  Representation of Stellar `UInt64` type.
  """
  @behaviour XDR.Declaration

  @type t :: %__MODULE__{datum: non_neg_integer()}

  defstruct [:datum]

  @spec new(uint64 :: non_neg_integer()) :: t()
  def new(uint64), do: %__MODULE__{datum: uint64}

  @impl true
  def encode_xdr(uint64) do
    uint64
    |> XDR.HyperUInt.new()
    |> XDR.HyperUInt.encode_xdr()
  end

  @impl true
  def encode_xdr!(uint64) do
    uint64
    |> XDR.HyperUInt.new()
    |> XDR.HyperUInt.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, term \\ nil)

  def decode_xdr(bytes, _term) do
    case XDR.HyperUInt.decode_xdr(bytes) do
      {:ok, {%XDR.HyperUInt{datum: uint64}, rest}} -> {:ok, {new(uint64), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, term \\ nil)

  def decode_xdr!(bytes, _term) do
    {%XDR.HyperUInt{datum: uint64}, rest} = XDR.HyperUInt.decode_xdr!(bytes)
    {new(uint64), rest}
  end
end

defmodule Stellar.XDR.UInt256 do
  @moduledoc """
  Representation of Stellar `UInt256` type.
  """
  @behaviour XDR.Declaration

  @type t :: %__MODULE__{datum: binary()}

  defstruct [:datum]

  @spec new(uint256 :: binary()) :: t()
  def new(uint256), do: %__MODULE__{datum: uint256}

  @impl true
  defdelegate encode_xdr(uint256), to: Stellar.XDR.Opaque32

  @impl true
  defdelegate encode_xdr!(uint256), to: Stellar.XDR.Opaque32

  @impl true
  def decode_xdr(bytes, term \\ nil)

  def decode_xdr(bytes, _term) do
    case Stellar.XDR.Opaque32.decode_xdr(bytes) do
      {:ok, {%Stellar.XDR.Opaque32{opaque: uint256}, rest}} -> {:ok, {new(uint256), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, term \\ nil)

  def decode_xdr!(bytes, _term) do
    {%Stellar.XDR.Opaque32{opaque: uint256}, rest} = Stellar.XDR.Opaque32.decode_xdr!(bytes)
    {new(uint256), rest}
  end
end
