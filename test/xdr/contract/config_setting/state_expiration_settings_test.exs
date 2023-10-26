defmodule StellarBase.XDR.StateArchivalSettingsTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    StateArchivalSettings,
    UInt32,
    Int64,
    UInt64
  }

  setup do
    max_entry_ttl = UInt32.new(100)
    min_temporary_ttl = UInt32.new(50)
    min_persistent_ttl = UInt32.new(60)
    starting_eviction_scan_level = UInt32.new(5)
    persistent_rent_rate_denominator = Int64.new(100)
    temp_rent_rate_denominator = Int64.new(200)
    max_entries_to_archive = UInt32.new(500)
    bucket_list_size_window_sample_size = UInt32.new(1000)
    eviction_scan_size = UInt64.new(5000)

    binary =
      <<0, 0, 0, 100, 0, 0, 0, 50, 0, 0, 0, 60, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0,
        200, 0, 0, 1, 244, 0, 0, 3, 232, 0, 0, 0, 0, 0, 0, 19, 136, 0, 0, 0, 5>>

    state_expiration_settings =
      StateArchivalSettings.new(
        max_entry_ttl,
        min_temporary_ttl,
        min_persistent_ttl,
        persistent_rent_rate_denominator,
        temp_rent_rate_denominator,
        max_entries_to_archive,
        bucket_list_size_window_sample_size,
        eviction_scan_size,
        starting_eviction_scan_level
      )

    %{
      max_entry_ttl: max_entry_ttl,
      min_temporary_ttl: min_temporary_ttl,
      min_persistent_ttl: min_persistent_ttl,
      starting_eviction_scan_level: starting_eviction_scan_level,
      persistent_rent_rate_denominator: persistent_rent_rate_denominator,
      temp_rent_rate_denominator: temp_rent_rate_denominator,
      max_entries_to_archive: max_entries_to_archive,
      bucket_list_size_window_sample_size: bucket_list_size_window_sample_size,
      eviction_scan_size: eviction_scan_size,
      binary: binary,
      state_expiration_settings: state_expiration_settings
    }
  end

  test "new/1", %{
    max_entry_ttl: max_entry_ttl,
    min_temporary_ttl: min_temporary_ttl,
    min_persistent_ttl: min_persistent_ttl,
    starting_eviction_scan_level: starting_eviction_scan_level,
    persistent_rent_rate_denominator: persistent_rent_rate_denominator,
    temp_rent_rate_denominator: temp_rent_rate_denominator,
    max_entries_to_archive: max_entries_to_archive,
    bucket_list_size_window_sample_size: bucket_list_size_window_sample_size,
    eviction_scan_size: eviction_scan_size
  } do
    %StateArchivalSettings{
      max_entry_ttl: ^max_entry_ttl,
      min_temporary_ttl: ^min_temporary_ttl,
      min_persistent_ttl: ^min_persistent_ttl,
      persistent_rent_rate_denominator: ^persistent_rent_rate_denominator,
      temp_rent_rate_denominator: ^temp_rent_rate_denominator,
      max_entries_to_archive: ^max_entries_to_archive,
      bucket_list_size_window_sample_size: ^bucket_list_size_window_sample_size,
      eviction_scan_size: ^eviction_scan_size,
      starting_eviction_scan_level: ^starting_eviction_scan_level
    } =
      StateArchivalSettings.new(
        max_entry_ttl,
        min_temporary_ttl,
        min_persistent_ttl,
        persistent_rent_rate_denominator,
        temp_rent_rate_denominator,
        max_entries_to_archive,
        bucket_list_size_window_sample_size,
        eviction_scan_size,
        starting_eviction_scan_level
      )
  end

  test "encode_xdr/1", %{
    binary: binary,
    max_entry_ttl: max_entry_ttl,
    min_temporary_ttl: min_temporary_ttl,
    min_persistent_ttl: min_persistent_ttl,
    starting_eviction_scan_level: starting_eviction_scan_level,
    persistent_rent_rate_denominator: persistent_rent_rate_denominator,
    temp_rent_rate_denominator: temp_rent_rate_denominator,
    max_entries_to_archive: max_entries_to_archive,
    bucket_list_size_window_sample_size: bucket_list_size_window_sample_size,
    eviction_scan_size: eviction_scan_size
  } do
    {:ok, ^binary} =
      StateArchivalSettings.new(
        max_entry_ttl,
        min_temporary_ttl,
        min_persistent_ttl,
        persistent_rent_rate_denominator,
        temp_rent_rate_denominator,
        max_entries_to_archive,
        bucket_list_size_window_sample_size,
        eviction_scan_size,
        starting_eviction_scan_level
      )
      |> StateArchivalSettings.encode_xdr()
  end

  test "encode_xdr!/1", %{
    binary: binary,
    max_entry_ttl: max_entry_ttl,
    min_temporary_ttl: min_temporary_ttl,
    min_persistent_ttl: min_persistent_ttl,
    starting_eviction_scan_level: starting_eviction_scan_level,
    persistent_rent_rate_denominator: persistent_rent_rate_denominator,
    temp_rent_rate_denominator: temp_rent_rate_denominator,
    max_entries_to_archive: max_entries_to_archive,
    bucket_list_size_window_sample_size: bucket_list_size_window_sample_size,
    eviction_scan_size: eviction_scan_size
  } do
    ^binary =
      StateArchivalSettings.new(
        max_entry_ttl,
        min_temporary_ttl,
        min_persistent_ttl,
        persistent_rent_rate_denominator,
        temp_rent_rate_denominator,
        max_entries_to_archive,
        bucket_list_size_window_sample_size,
        eviction_scan_size,
        starting_eviction_scan_level
      )
      |> StateArchivalSettings.encode_xdr!()
  end

  test "decode_xdr/2", %{binary: binary, state_expiration_settings: state_expiration_settings} do
    {:ok, {^state_expiration_settings, ""}} = StateArchivalSettings.decode_xdr(binary)
  end

  test "decode_xdr/2 with an invalid binary" do
    {:error, :not_binary} = StateArchivalSettings.decode_xdr(123)
  end

  test "decode_xdr!/2", %{binary: binary, state_expiration_settings: state_expiration_settings} do
    {^state_expiration_settings, ^binary} = StateArchivalSettings.decode_xdr!(binary <> binary)
  end
end
