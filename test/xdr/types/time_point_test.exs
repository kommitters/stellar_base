defmodule StellarBase.XDR.TimePointTest do
  use ExUnit.Case

  alias StellarBase.XDR.{TimePoint, Uint64}

  describe "TimePoint" do
    setup do
      %{
        time_point: TimePoint.new(Uint64.new(1234)),
        binary: <<0, 0, 0, 0, 0, 0, 4, 210>>
      }
    end

    test "new/1" do
      %TimePoint{time_point: %Uint64{datum: 1234}} = TimePoint.new(Uint64.new(1234))
    end

    test "encode_xdr/1", %{time_point: time_point, binary: binary} do
      {:ok, ^binary} = TimePoint.encode_xdr(time_point)
    end

    test "encode_xdr/1 a non-integer value" do
      {:error, :not_integer} =
        "hello"
        |> Uint64.new()
        |> TimePoint.new()
        |> TimePoint.encode_xdr()
    end

    test "encode_xdr!/1", %{time_point: time_point, binary: binary} do
      ^binary = TimePoint.encode_xdr!(time_point)
    end

    test "decode_xdr/2", %{time_point: time_point, binary: binary} do
      {:ok, {^time_point, ""}} = TimePoint.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = TimePoint.decode_xdr(123)
    end

    test "decode_xdr!/2", %{time_point: time_point, binary: binary} do
      {^time_point, ^binary} = TimePoint.decode_xdr!(binary <> binary)
    end
  end
end
