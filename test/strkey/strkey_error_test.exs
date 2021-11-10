defmodule StellarBase.StrKeyErrorTest do
  use ExUnit.Case

  alias StellarBase.StrKeyError

  test "invalid_binary" do
    assert_raise StrKeyError, "cannot encode nil data", fn ->
      raise StrKeyError, :invalid_binary
    end
  end

  test "invalid_data" do
    assert_raise StrKeyError, "cannot decode nil data", fn ->
      raise StrKeyError, :invalid_data
    end
  end

  test "invalid_checksum" do
    assert_raise StrKeyError, "invalid checksum", fn ->
      raise StrKeyError, :invalid_checksum
    end
  end

  test "unmatched_version_byte" do
    assert_raise StrKeyError, "version byte does not match", fn ->
      raise StrKeyError, :unmatched_version_byte
    end
  end

  test "error" do
    assert_raise StrKeyError, "error", fn ->
      raise StrKeyError, "error"
    end
  end
end
