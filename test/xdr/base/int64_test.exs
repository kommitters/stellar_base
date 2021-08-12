defmodule Stellar.XDR.Int64Test do
  use ExUnit.Case

  alias Stellar.XDR.Int64

  describe "Int64" do
    setup do
      %{
        int64: Int64.new(123_456_789),
        binary: <<0, 0, 0, 0, 7, 91, 205, 21>>
      }
    end

    test "new/1" do
      %Int64{datum: 123_456_789} = Int64.new(123_456_789)
    end

    test "encode_xdr/1", %{int64: int64, binary: binary} do
      {:ok, ^binary} = Int64.encode_xdr(int64)
    end

    test "encode_xdr!/1", %{int64: int64, binary: binary} do
      ^binary = Int64.encode_xdr!(int64)
    end

    test "decode_xdr/2", %{int64: int64, binary: binary} do
      {:ok, {^int64, ""}} = Int64.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{int64: int64, binary: binary} do
      {^int64, ^binary} = Int64.decode_xdr!(binary <> binary)
    end
  end
end
