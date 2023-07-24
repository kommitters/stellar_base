defmodule StellarBase.XDR.ContractDataDurabilityTest do
  use ExUnit.Case

  alias StellarBase.XDR.ContractDataDurability

  setup do
    temporary_durability = :TEMPORARY
    persistent_durability = :PERSISTENT

    temporary = ContractDataDurability.new(temporary_durability)
    persistent = ContractDataDurability.new(persistent_durability)

    %{
      temporary_durability: temporary_durability,
      persistent_durability: persistent_durability,
      temporary: temporary,
      persistent: persistent
    }
  end

  test "new/1 with temporary durability", %{temporary_durability: temporary_durability} do
    %ContractDataDurability{identifier: ^temporary_durability} =
      ContractDataDurability.new(temporary_durability)
  end

  test "new/1 with persistent durability", %{persistent_durability: persistent_durability} do
    %ContractDataDurability{identifier: ^persistent_durability} =
      ContractDataDurability.new(persistent_durability)
  end

  test "encode_xdr/1 with temporary durability", %{temporary: temporary} do
    {:ok, <<0, 0, 0, 0>>} = ContractDataDurability.encode_xdr(temporary)
  end

  test "encode_xdr/1 with persistent durability", %{persistent: persistent} do
    {:ok, <<0, 0, 0, 1>>} = ContractDataDurability.encode_xdr(persistent)
  end

  test "encode_xdr!/1 with temporary durability", %{temporary: temporary} do
    <<0, 0, 0, 0>> = ContractDataDurability.encode_xdr!(temporary)
  end

  test "encode_xdr!/1 with persistent durability", %{persistent: persistent} do
    <<0, 0, 0, 1>> = ContractDataDurability.encode_xdr!(persistent)
  end

  test "decode_xdr/2 with temporary durability", %{temporary: temporary} do
    {:ok, {^temporary, ""}} =
      ContractDataDurability.decode_xdr(ContractDataDurability.encode_xdr!(temporary))
  end

  test "decode_xdr/2 with persistent durability", %{persistent: persistent} do
    {:ok, {^persistent, ""}} =
      ContractDataDurability.decode_xdr(ContractDataDurability.encode_xdr!(persistent))
  end

  test "decode_xdr!/2 with temporary durability", %{temporary: temporary} do
    {^temporary, ""} =
      ContractDataDurability.decode_xdr!(ContractDataDurability.encode_xdr!(temporary))
  end

  test "decode_xdr!/2 with persistent durability", %{persistent: persistent} do
    {^persistent, ""} =
      ContractDataDurability.decode_xdr!(ContractDataDurability.encode_xdr!(persistent))
  end

  test "decode_xdr!/2 with an invalid binary" do
    {:error, :not_binary} = ContractDataDurability.decode_xdr(123)
  end
end
