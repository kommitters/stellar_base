defmodule StellarBase.XDR.StateExpirationSettingsTest do
  use ExUnit.Case

  alias StellarBase.XDR.{
    StateExpirationSettings,
    UInt32,
    Int64,
    UInt64
  }

  setup do
    max_entry_expiration = UInt32.new(100)
    min_temp_entry_expiration = UInt32.new(50)
    min_persistent_entry_expiration = UInt32.new(60)
    auto_bump_ledgers = UInt32.new(5)
    persistent_rent_rate_denominator = Int64.new(100)
    temp_rent_rate_denominator = Int64.new(200)
    max_entries_to_expire = UInt32.new(500)
    bucket_list_size_window_sample_size = UInt32.new(1000)
    eviction_scan_size = UInt64.new(5000)

    binary =
      <<0, 0, 0, 100, 0, 0, 0, 50, 0, 0, 0, 60, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0, 0, 0,
        0, 0, 0, 200, 0, 0, 1, 244, 0, 0, 3, 232, 0, 0, 0, 0, 0, 0, 19, 136>>

    state_expiration_settings =
      StateExpirationSettings.new(
        max_entry_expiration,
        min_temp_entry_expiration,
        min_persistent_entry_expiration,
        auto_bump_ledgers,
        persistent_rent_rate_denominator,
        temp_rent_rate_denominator,
        max_entries_to_expire,
        bucket_list_size_window_sample_size,
        eviction_scan_size
      )

    %{
      max_entry_expiration: max_entry_expiration,
      min_temp_entry_expiration: min_temp_entry_expiration,
      min_persistent_entry_expiration: min_persistent_entry_expiration,
      auto_bump_ledgers: auto_bump_ledgers,
      persistent_rent_rate_denominator: persistent_rent_rate_denominator,
      temp_rent_rate_denominator: temp_rent_rate_denominator,
      max_entries_to_expire: max_entries_to_expire,
      bucket_list_size_window_sample_size: bucket_list_size_window_sample_size,
      eviction_scan_size: eviction_scan_size,
      binary: binary,
      state_expiration_settings: state_expiration_settings
    }
  end

  test "new/1", %{
    max_entry_expiration: max_entry_expiration,
    min_temp_entry_expiration: min_temp_entry_expiration,
    min_persistent_entry_expiration: min_persistent_entry_expiration,
    auto_bump_ledgers: auto_bump_ledgers,
    persistent_rent_rate_denominator: persistent_rent_rate_denominator,
    temp_rent_rate_denominator: temp_rent_rate_denominator,
    max_entries_to_expire: max_entries_to_expire,
    bucket_list_size_window_sample_size: bucket_list_size_window_sample_size,
    eviction_scan_size: eviction_scan_size
  } do
    %StateExpirationSettings{
      max_entry_expiration: ^max_entry_expiration,
      min_temp_entry_expiration: ^min_temp_entry_expiration,
      min_persistent_entry_expiration: ^min_persistent_entry_expiration,
      auto_bump_ledgers: ^auto_bump_ledgers,
      persistent_rent_rate_denominator: ^persistent_rent_rate_denominator,
      temp_rent_rate_denominator: ^temp_rent_rate_denominator,
      max_entries_to_expire: ^max_entries_to_expire,
      bucket_list_size_window_sample_size: ^bucket_list_size_window_sample_size,
      eviction_scan_size: ^eviction_scan_size
    } =
      StateExpirationSettings.new(
        max_entry_expiration,
        min_temp_entry_expiration,
        min_persistent_entry_expiration,
        auto_bump_ledgers,
        persistent_rent_rate_denominator,
        temp_rent_rate_denominator,
        max_entries_to_expire,
        bucket_list_size_window_sample_size,
        eviction_scan_size
      )
  end

  test "encode_xdr/1", %{
    binary: binary,
    max_entry_expiration: max_entry_expiration,
    min_temp_entry_expiration: min_temp_entry_expiration,
    min_persistent_entry_expiration: min_persistent_entry_expiration,
    auto_bump_ledgers: auto_bump_ledgers,
    persistent_rent_rate_denominator: persistent_rent_rate_denominator,
    temp_rent_rate_denominator: temp_rent_rate_denominator,
    max_entries_to_expire: max_entries_to_expire,
    bucket_list_size_window_sample_size: bucket_list_size_window_sample_size,
    eviction_scan_size: eviction_scan_size
  } do
    {:ok, ^binary} =
      StateExpirationSettings.new(
        max_entry_expiration,
        min_temp_entry_expiration,
        min_persistent_entry_expiration,
        auto_bump_ledgers,
        persistent_rent_rate_denominator,
        temp_rent_rate_denominator,
        max_entries_to_expire,
        bucket_list_size_window_sample_size,
        eviction_scan_size
      )
      |> StateExpirationSettings.encode_xdr()
  end

  test "encode_xdr!/1", %{
    binary: binary,
    max_entry_expiration: max_entry_expiration,
    min_temp_entry_expiration: min_temp_entry_expiration,
    min_persistent_entry_expiration: min_persistent_entry_expiration,
    auto_bump_ledgers: auto_bump_ledgers,
    persistent_rent_rate_denominator: persistent_rent_rate_denominator,
    temp_rent_rate_denominator: temp_rent_rate_denominator,
    max_entries_to_expire: max_entries_to_expire,
    bucket_list_size_window_sample_size: bucket_list_size_window_sample_size,
    eviction_scan_size: eviction_scan_size
  } do
    ^binary =
      StateExpirationSettings.new(
        max_entry_expiration,
        min_temp_entry_expiration,
        min_persistent_entry_expiration,
        auto_bump_ledgers,
        persistent_rent_rate_denominator,
        temp_rent_rate_denominator,
        max_entries_to_expire,
        bucket_list_size_window_sample_size,
        eviction_scan_size
      )
      |> StateExpirationSettings.encode_xdr!()
  end

  test "decode_xdr/2", %{binary: binary, state_expiration_settings: state_expiration_settings} do
    {:ok, {^state_expiration_settings, ""}} = StateExpirationSettings.decode_xdr(binary)
  end

  test "decode_xdr/2 with an invalid binary" do
    {:error, :not_binary} = StateExpirationSettings.decode_xdr(123)
  end

  test "decode_xdr!/2", %{binary: binary, state_expiration_settings: state_expiration_settings} do
    {^state_expiration_settings, ^binary} = StateExpirationSettings.decode_xdr!(binary <> binary)
  end
end
