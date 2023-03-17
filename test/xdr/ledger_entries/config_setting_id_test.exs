defmodule StellarBase.XDR.ConfigSettingIDTest do
  use ExUnit.Case

  alias StellarBase.XDR.ConfigSettingID

  describe "ConfigSettingID" do
    setup do
      %{
        type: :CONFIG_SETTING_CONTRACT_MAX_SIZE,
        result: ConfigSettingID.new(:CONFIG_SETTING_CONTRACT_MAX_SIZE),
        binary: <<0, 0, 0, 0>>
      }
    end

    test "new/1", %{type: type} do
      %ConfigSettingID{identifier: ^type} = ConfigSettingID.new(type)
    end

    test "encode_xdr/1", %{result: result, binary: binary} do
      {:ok, ^binary} = ConfigSettingID.encode_xdr(result)
    end

    test "encode_xdr/1 with an invalid type" do
      {:error, :invalid_key} = ConfigSettingID.encode_xdr(%ConfigSettingID{identifier: :TEST})
    end

    test "encode_xdr!/1", %{result: result, binary: binary} do
      ^binary = ConfigSettingID.encode_xdr!(result)
    end

    test "decode_xdr/2", %{result: result, binary: binary} do
      {:ok, {^result, ""}} = ConfigSettingID.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid declaration" do
      {:error, :invalid_key} = ConfigSettingID.decode_xdr(<<1, 0, 0, 1>>)
    end

    test "decode_xdr!/2", %{result: result, binary: binary} do
      {^result, ^binary} = ConfigSettingID.decode_xdr!(binary <> binary)
    end

    test "decode_xdr!/2 with an error type", %{binary: binary} do
      {%ConfigSettingID{identifier: _}, ""} = ConfigSettingID.decode_xdr!(binary)
    end
  end
end
