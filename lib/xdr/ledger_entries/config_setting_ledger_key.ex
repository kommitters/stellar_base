defmodule StellarBase.XDR.LedgerKeyConfigSetting do
  @moduledoc """
  Representation of Stellar `LedgerKeyConfigSetting` type.
  """

  alias StellarBase.XDR.ConfigSettingID

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(config_setting_id: ConfigSettingID)

  @type t :: %__MODULE__{config_setting_id: ConfigSettingID.t()}

  defstruct [:config_setting_id]

  @spec new(config_setting_id :: ConfigSettingID.t()) :: t()
  def new(%ConfigSettingID{} = config_setting_id),
    do: %__MODULE__{config_setting_id: config_setting_id}

  @impl true
  def encode_xdr(%__MODULE__{config_setting_id: config_setting_id}) do
    [config_setting_id: config_setting_id]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{config_setting_id: config_setting_id}) do
    [config_setting_id: config_setting_id]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [config_setting_id: config_setting_id]}, rest}} ->
        {:ok, {new(config_setting_id), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [config_setting_id: config_setting_id]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)

    {new(config_setting_id), rest}
  end
end
