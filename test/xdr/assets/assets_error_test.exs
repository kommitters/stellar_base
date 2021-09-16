defmodule Stellar.XDR.Assets.ErrorTest do
  use ExUnit.Case

  alias Stellar.XDR.{AssetCode4Error, AssetCode12Error}

  describe "AssetCode4Error" do
    test "when receives :invalid_lenght" do
      assert_raise AssetCode4Error,
                   "Invalid code lenght for AssetCode4. A string between 1 and 4 characters is expected.",
                   fn ->
                     raise AssetCode4Error, :invalid_length
                   end
    end
  end

  describe "AssetCode12Error" do
    test "when receives :invalid_lenght" do
      assert_raise AssetCode12Error,
                   "Invalid code lenght for AssetCode12. A string between 5 and 12 characters is expected.",
                   fn ->
                     raise AssetCode12Error, :invalid_length
                   end
    end
  end
end
