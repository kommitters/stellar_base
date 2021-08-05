defmodule Stellar.XDR.OptionalTimeBoundsTest do
  use ExUnit.Case

  alias Stellar.XDR.{Void, TimePoint, TimeBounds, OptionalTimeBounds}

  describe "OptionalTimeBounds" do
    setup do
      min_time = TimePoint.new(123)
      max_time = TimePoint.new(321)
      time_bounds = TimeBounds.new(min_time, max_time)

      %{
        time_bounds: time_bounds,
        optional_time_bounds: OptionalTimeBounds.new(time_bounds),
        binary: <<0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 123, 0, 0, 0, 0, 0, 0, 1, 65>>
      }
    end

    test "new/1", %{time_bounds: time_bounds} do
      %OptionalTimeBounds{time_bounds: ^time_bounds} = OptionalTimeBounds.new(time_bounds)
    end

    test "encode_xdr/1", %{optional_time_bounds: optional_time_bounds, binary: binary} do
      {:ok, ^binary} = OptionalTimeBounds.encode_xdr(optional_time_bounds)
    end

    test "encode_xdr!/1", %{optional_time_bounds: optional_time_bounds, binary: binary} do
      ^binary = OptionalTimeBounds.encode_xdr!(optional_time_bounds)
    end

    test "decode_xdr/2", %{optional_time_bounds: optional_time_bounds, binary: binary} do
      {:ok, {^optional_time_bounds, ""}} = OptionalTimeBounds.decode_xdr(binary)
    end

    test "decode_xdr/2 when time_bounds are not opted" do
      no_timebounds = <<0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 123, 0, 0, 0, 0, 0, 0, 1, 65>>

      {:ok, {%Void{value: nil}, <<0, 0, 0, 0, 0, 0, 0, 123, 0, 0, 0, 0, 0, 0, 1, 65>>}} =
        OptionalTimeBounds.decode_xdr(no_timebounds)
    end

    test "decode_xdr!/2", %{optional_time_bounds: optional_time_bounds, binary: binary} do
      {^optional_time_bounds, ^binary} = OptionalTimeBounds.decode_xdr!(binary <> binary)
    end
  end
end
