defmodule StellarBase.XDR.ConfigSettingTypeTest do
  use ExUnit.Case

  alias StellarBase.XDR.ConfigSettingType

  describe "ConfigSettingType" do
    setup do
      %{
        type: :CONFIG_SETTING_TYPE_UINT32,
        result: ConfigSettingType.new(:CONFIG_SETTING_TYPE_UINT32),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{type: type} do
      %ConfigSettingType{identifier: ^type} = ConfigSettingType.new(type)
    end

    test "encode_xdr/1", %{result: result, binary: binary} do
      {:ok, ^binary} = ConfigSettingType.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid type" do
      {:error, :invalid_key} = ConfigSettingType.encode_xdr(%ConfigSettingType{identifier: :TEST})
    end

    test "encode_xdr!/1", %{result: result, binary: binary} do
      ^binary = ConfigSettingType.encode_xdr!(result)
    end

    test "decode_xdr/2", %{result: result, binary: binary} do
      {:ok, {^result, ""}} = ConfigSettingType.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = ConfigSettingType.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{result: result, binary: binary} do
      {^result, ^binary} = ConfigSettingType.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error type", %{binary: binary} do
      {%ConfigSettingType{identifier: _}, ""} = ConfigSettingType.decode_xdr!(binary)
    end
  end
end
