defmodule StellarBase.XDR.ConfigSettingEntry do
  @moduledoc """
  Representation of Stellar `ConfigSettingEntry` type.
  """

  alias StellarBase.XDR.{ConfigSettingID, ConfigSetting, Ext}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(
                 config_setting_id: ConfigSettingID,
                 config_setting: ConfigSetting,
                 ext: Ext
               )

  @type t :: %__MODULE__{
          config_setting_id: ConfigSettingID.t(),
          config_setting: ConfigSetting.t(),
          ext: Ext.t()
        }

  defstruct [:config_setting_id, :config_setting, :ext]

  @spec new(
          config_setting_id :: ConfigSettingID.t(),
          config_setting :: ConfigSetting.t(),
          ext :: Ext.t()
        ) :: t()
  def new(
        %ConfigSettingID{} = config_setting_id,
        %ConfigSetting{} = config_setting,
        %Ext{} = ext
      ),
      do: %__MODULE__{
        config_setting_id: config_setting_id,
        config_setting: config_setting,
        ext: ext
      }

  @impl true
  def encode_xdr(%__MODULE__{
        config_setting_id: config_setting_id,
        config_setting: config_setting,
        ext: ext
      }) do
    [config_setting_id: config_setting_id, config_setting: config_setting, ext: ext]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{
        config_setting_id: config_setting_id,
        config_setting: config_setting,
        ext: ext
      }) do
    [config_setting_id: config_setting_id, config_setting: config_setting, ext: ext]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok,
       {%XDR.Struct{
          components: [
            config_setting_id: config_setting_id,
            config_setting: config_setting,
            ext: ext
          ]
        }, rest}} ->
        {:ok, {new(config_setting_id, config_setting, ext), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{
       components: [
         config_setting_id: config_setting_id,
         config_setting: config_setting,
         ext: ext
       ]
     }, rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(config_setting_id, config_setting, ext), rest}
  end
end
