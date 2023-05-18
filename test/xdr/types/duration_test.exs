defmodule StellarBase.XDR.DurationTest do
  use ExUnit.Case

  alias StellarBase.XDR.{Duration, Uint64}

  describe "Duration" do
    setup do
      %{
        duration: Duration.new(Uint64.new(1234)),
        binary: <<0, 0, 0, 0, 0, 0, 4, 210>>
      }
    end

    test "new/1" do
      %Duration{duration: %Uint64{datum: 1234}} = Duration.new(Uint64.new(1234))
    end

    test "encode_xdr/1", %{duration: duration, binary: binary} do
      {:ok, ^binary} = Duration.encode_xdr(duration)
    end

    test "encode_xdr/1 a non-integer value" do
      {:error, :not_integer} =
        "hello"
        |> Uint64.new()
        |> Duration.new()
        |> Duration.encode_xdr()
    end

    test "encode_xdr!/1", %{duration: duration, binary: binary} do
      ^binary = Duration.encode_xdr!(duration)
    end

    test "decode_xdr/2", %{duration: duration, binary: binary} do
      {:ok, {^duration, ""}} = Duration.decode_xdr(binary)
    end

    test "decode_xdr/2 with an invalid binary" do
      {:error, :not_binary} = Duration.decode_xdr(123)
    end

    test "decode_xdr!/2", %{duration: duration, binary: binary} do
      {^duration, ^binary} = Duration.decode_xdr!(binary <> binary)
    end
  end
end
