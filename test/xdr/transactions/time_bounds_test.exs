defmodule Stellar.XDR.TimeBoundsTest do
  use ExUnit.Case

  alias Stellar.XDR.{TimePoint, TimeBounds}

  describe "TimeBounds" do
    setup do
      min_time = TimePoint.new(123)
      max_time = TimePoint.new(321)

      %{
        min_time: min_time,
        max_time: max_time,
        time_bounds: TimeBounds.new(min_time, max_time),
        binary: <<0, 0, 0, 0, 0, 0, 0, 123, 0, 0, 0, 0, 0, 0, 1, 65>>
      }
    end

    test "new/1", %{min_time: min_time, max_time: max_time} do
      %TimeBounds{min_time: ^min_time, max_time: ^max_time} = TimeBounds.new(min_time, max_time)
    end

    test "encode_xdr/1", %{time_bounds: time_bounds, binary: binary} do
      {:ok, ^binary} = TimeBounds.encode_xdr(time_bounds)
    end

    test "encode_xdr!/1", %{time_bounds: time_bounds, binary: binary} do
      ^binary = TimeBounds.encode_xdr!(time_bounds)
    end

    test "decode_xdr/2", %{time_bounds: time_bounds, binary: binary} do
      {:ok, {^time_bounds, ""}} = TimeBounds.decode_xdr(binary)
    end

    test "decode_xdr!/2", %{time_bounds: time_bounds, binary: binary} do
      {^time_bounds, ^binary} = TimeBounds.decode_xdr!(binary <> binary)
    end
  end
end
