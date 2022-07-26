defmodule StellarBase.XDR.ExtensionPoint do
  @moduledoc """
  Representation of Stellar `ExtensionPoint` type.
  """
  alias StellarBase.XDR.Void

  @behaviour XDR.Declaration

  @arms %{0 => Void}

  @type t :: %__MODULE__{extension_point: Void.t(), type: non_neg_integer()}

  defstruct [:extension_point, :type]

  @spec new(extension_point :: Void.t(), type :: non_neg_integer()) :: t()
  def new(extension_point, type),
    do: %__MODULE__{extension_point: extension_point, type: type}

  @impl true
  def encode_xdr(%__MODULE__{extension_point: extension_point, type: type}) do
    IO.inspect(extension_point)

    type
    |> XDR.Int.new()
    |> XDR.Union.new(@arms, extension_point)
    |> XDR.Union.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{extension_point: extension_point, type: type}) do
    type
    |> XDR.Int.new()
    |> XDR.Union.new(@arms, extension_point)
    |> XDR.Union.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ union_spec())

  def decode_xdr(bytes, spec) do
    case XDR.Union.decode_xdr(bytes, spec) do
      {:ok, {{type, key}, rest}} -> {:ok, {new(key, type), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ union_spec())

  def decode_xdr!(bytes, spec) do
    {{type, key}, rest} = XDR.Union.decode_xdr!(bytes, spec)
    {new(key, type), rest}
  end

  @spec union_spec() :: XDR.Union.t()
  defp union_spec, do: XDR.Union.new(XDR.Int.new(0), @arms)
end
