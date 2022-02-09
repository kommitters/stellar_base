defmodule StellarBase.StrKeyErrorTest do
  use ExUnit.Case

  alias StellarBase.StrKeyError

  test "invalid_binary" do
    assert_raise StrKeyError, "cannot encode nil data", fn ->
      raise StrKeyError, :invalid_binary
    end
  end

  test "nil_data" do
    assert_raise StrKeyError, "cannot decode nil data", fn ->
      raise StrKeyError, :cant_decode_nil_data
    end
  end

  test "invalid_data" do
    assert_raise StrKeyError, "cannot decode data", fn ->
      raise StrKeyError, :invalid_data_to_decode
    end
  end

  test "invalid_checksum" do
    assert_raise StrKeyError, "invalid checksum", fn ->
      raise StrKeyError, :invalid_checksum
    end
  end

  test "unmatched_version_byte" do
    assert_raise StrKeyError, "version bytes does not match", fn ->
      raise StrKeyError, :unmatched_version_bytes
    end
  end

  test "error" do
    assert_raise StrKeyError, "error", fn ->
      raise StrKeyError, "error"
    end
  end
end
