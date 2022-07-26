defmodule StellarBase.XDR.PreconditionTypeTest do
  use ExUnit.Case

  alias StellarBase.XDR.PreconditionType

  describe "PreconditionType" do
    setup do
      %{
        encoded_binary: <<0, 0, 0, 1>>,
        identifier: :PRECOND_TIME,
        xdr_type: PreconditionType.new(:PRECOND_TIME)
      }
    end

    test "new/1", %{identifier: type} do
      %PreconditionType{identifier: ^type} = PreconditionType.new(:PRECOND_TIME)
    end

    test "encode_xdr/1", %{xdr_type: xdr_type, encoded_binary: binary} do
      {:ok, ^binary} = PreconditionType.encode_xdr(xdr_type)
    end

    test "encode_xdr!/1", %{xdr_type: xdr_type, encoded_binary: binary} do
      ^binary = PreconditionType.encode_xdr!(xdr_type)
    end

    test "decode_xdr/2", %{xdr_type: xdr_type, encoded_binary: binary} do
      {:ok, {^xdr_type, ""}} = PreconditionType.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = PreconditionType.decode_xdr(123)
    end

    test "decode_xdr!/2", %{xdr_type: xdr_type, encoded_binary: binary} do
      {^xdr_type, ^binary} = PreconditionType.decode_xdr!(binary <> binary)
    end

    test "invalid identifier" do
      {:error, :invalid_key} =
        PreconditionType.encode_xdr(%PreconditionType{identifier: PRECOND_INVALID})
    end
  end
end
