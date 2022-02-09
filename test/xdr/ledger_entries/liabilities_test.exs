defmodule StellarBase.XDR.LiabilitiesTest do
  use ExUnit.Case

  alias StellarBase.XDR.{Int64, Liabilities}

  describe "Liabilities" do
    setup do
      buying = Int64.new(20)
      selling = Int64.new(10)

      %{
        buying: buying,
        selling: selling,
        liabilities: Liabilities.new(buying, selling),
        binary: <<0, 0, 0, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 0, 10>>
      }
    end

    test "new/1", %{buying: buying, selling: selling} do
      %Liabilities{buying: ^buying, selling: ^selling} = Liabilities.new(buying, selling)
    end

    test "encode_xdr/1", %{liabilities: liabilities, binary: binary} do
      {:ok, ^binary} = Liabilities.encode_xdr(liabilities)
    end

    test "encode_xdr!/1", %{liabilities: liabilities, binary: binary} do
      ^binary = Liabilities.encode_xdr!(liabilities)
    end

    test "decode_xdr/2", %{liabilities: liabilities, binary: binary} do
      {:ok, {^liabilities, ""}} = Liabilities.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = Liabilities.decode_xdr(123)
    end

    test "decode_xdr!/2", %{liabilities: liabilities, binary: binary} do
      {^liabilities, ^binary} = Liabilities.decode_xdr!(binary <> binary)
    end
  end
end
