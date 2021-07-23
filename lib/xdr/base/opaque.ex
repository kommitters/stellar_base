defmodule Stellar.XDR.Opaque4 do
  @moduledoc """
  Representation of Stellar `Opaque4` type.
  """
  @behaviour XDR.Declaration

  @type t :: %__MODULE__{opaque: binary(), length: integer()}

  defstruct [:opaque, :length]

  @length 4
  @opaque_spec XDR.FixedOpaque.new(nil, @length)

  @spec new(opaque :: binary()) :: t()
  def new(opaque), do: %__MODULE__{opaque: opaque, length: @length}

  @impl true
  def encode_xdr(opaque) do
    opaque
    |> XDR.FixedOpaque.new(@length)
    |> XDR.FixedOpaque.encode_xdr()
  end

  @impl true
  def encode_xdr!(opaque) do
    opaque
    |> XDR.FixedOpaque.new(@length)
    |> XDR.FixedOpaque.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ @opaque_spec)

  def decode_xdr(bytes, spec) do
    case XDR.FixedOpaque.decode_xdr(bytes, spec) do
      {:ok, {%XDR.FixedOpaque{opaque: opaque}, rest}} -> {:ok, {new(opaque), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ @opaque_spec)

  def decode_xdr!(bytes, spec) do
    {%XDR.FixedOpaque{opaque: opaque}, rest} = XDR.FixedOpaque.decode_xdr!(bytes, spec)
    {new(opaque), rest}
  end
end

defmodule Stellar.XDR.Opaque12 do
  @moduledoc """
  Representation of Stellar `Opaque12` type.
  """
  @behaviour XDR.Declaration

  @type t :: %__MODULE__{opaque: binary(), length: integer()}

  defstruct [:opaque, :length]

  @length 12
  @opaque_spec XDR.FixedOpaque.new(nil, @length)

  @spec new(opaque :: binary()) :: t()
  def new(opaque), do: %__MODULE__{opaque: opaque, length: @length}

  @impl true
  def encode_xdr(opaque) do
    opaque
    |> XDR.FixedOpaque.new(@length)
    |> XDR.FixedOpaque.encode_xdr()
  end

  @impl true
  def encode_xdr!(opaque) do
    opaque
    |> XDR.FixedOpaque.new(@length)
    |> XDR.FixedOpaque.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ @opaque_spec)

  def decode_xdr(bytes, spec) do
    case XDR.FixedOpaque.decode_xdr(bytes, spec) do
      {:ok, {%XDR.FixedOpaque{opaque: opaque}, rest}} -> {:ok, {new(opaque), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ @opaque_spec)

  def decode_xdr!(bytes, spec) do
    {%XDR.FixedOpaque{opaque: opaque}, rest} = XDR.FixedOpaque.decode_xdr!(bytes, spec)
    {new(opaque), rest}
  end
end

defmodule Stellar.XDR.Opaque32 do
  @moduledoc """
  Representation of Stellar `Opaque32` type.
  """
  @behaviour XDR.Declaration

  @type t :: %__MODULE__{opaque: binary(), length: integer()}

  defstruct [:opaque, :length]

  @length 32
  @opaque_spec XDR.FixedOpaque.new(nil, @length)

  @spec new(opaque :: binary()) :: t()
  def new(opaque), do: %__MODULE__{opaque: opaque, length: @length}

  @impl true
  def encode_xdr(opaque) do
    opaque
    |> XDR.FixedOpaque.new(@length)
    |> XDR.FixedOpaque.encode_xdr()
  end

  @impl true
  def encode_xdr!(opaque) do
    opaque
    |> XDR.FixedOpaque.new(@length)
    |> XDR.FixedOpaque.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ @opaque_spec)

  def decode_xdr(bytes, spec) do
    case XDR.FixedOpaque.decode_xdr(bytes, spec) do
      {:ok, {%XDR.FixedOpaque{opaque: opaque}, rest}} -> {:ok, {new(opaque), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ @opaque_spec)

  def decode_xdr!(bytes, spec) do
    {%XDR.FixedOpaque{opaque: opaque}, rest} = XDR.FixedOpaque.decode_xdr!(bytes, spec)
    {new(opaque), rest}
  end
end
