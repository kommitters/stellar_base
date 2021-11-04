defmodule Stellar.XDR.Thresholds.ErrorTest do
  @moduledoc false

  use ExUnit.Case

  alias Stellar.XDR.ThresholdsError

  describe "ThresholdsError" do
    test "when receives :invalid_thresholds_specification" do
      assert_raise ThresholdsError,
                   "Invalid thresholds specification. Thresholds must be provided in a keyword list specifying the master_weight, low, med and high thresholds respectively.",
                   fn ->
                     raise ThresholdsError, :invalid_thresholds_specification
                   end
    end
  end
end
