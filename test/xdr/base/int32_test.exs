defmodule Stellar.XDR.Int32Test do
  use ExUnit.Case

  alias Stellar.XDR.Int32

  describe "Int32" do
    setup do
      %{
        int32: Int32.new(1234),
        binary: <<0, 0, 4, 210>>
      }
    end

    test "new/1" do
      %Int32{datum: 1234} = Int32.new(1234)
    end

    test "encode_xdr/1", %{int32: int32, binary: binary} do
      {:ok, ^binary} = Int32.encode_xdr(int32)
    end

    test "encode_xdr!/1", %{int32: int32, binary: binary} do
      ^binary = Int32.encode_xdr!(int32)
    end

    test "decode_xdr/2", %{int32: int32, binary: binary} do
      {:ok, {^int32, ""}} = Int32.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{int32: int32, binary: binary} do
      {^int32, ^binary} = Int32.decode_xdr!(binary <> binary)
    end

    test "non-integer encode" do
      {:error, :not_integer} = Int32.encode_xdr(%Int32{datum: "1234"})
    end

    test "non-32bit integer" do
      {:error, :exceed_upper_limit} = Int32.encode_xdr(%Int32{datum: 12_343_838_387})
    end
  end
end
