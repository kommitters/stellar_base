defmodule StellarBase.XDR.Operations.InvokeHostFunction do
  @moduledoc """
  Representation of Stellar `InvokeHostFunction` type.
  """

  alias StellarBase.XDR.{ContractAuthList, LedgerFootprint, HostFunction}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(
                 host_function: HostFunction,
                 footprint: LedgerFootprint,
                 auth: ContractAuthList
               )

  @type host_function :: HostFunction.t()
  @type footprint :: LedgerFootprint.t()
  @type auth :: ContractAuthList.t()

  @type t :: %__MODULE__{host_function: host_function(), footprint: footprint(), auth: auth()}

  defstruct [:host_function, :footprint, :auth]

  @spec new(host_function :: host_function(), footprint :: footprint(), auth :: auth()) :: t()
  def new(
        %HostFunction{} = host_function,
        %LedgerFootprint{} = footprint,
        %ContractAuthList{} = auth
      ),
      do: %__MODULE__{host_function: host_function, footprint: footprint, auth: auth}

  @impl true
  def encode_xdr(%__MODULE__{host_function: host_function, footprint: footprint, auth: auth}) do
    [host_function: host_function, footprint: footprint, auth: auth]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{host_function: host_function, footprint: footprint, auth: auth}) do
    [host_function: host_function, footprint: footprint, auth: auth]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok,
       {%XDR.Struct{components: [host_function: host_function, footprint: footprint, auth: auth]},
        rest}} ->
        {:ok, {new(host_function, footprint, auth), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [host_function: host_function, footprint: footprint, auth: auth]},
     rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(host_function, footprint, auth), rest}
  end
end
