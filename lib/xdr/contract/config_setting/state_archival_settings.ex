defmodule StellarBase.XDR.StateArchivalSettings do
  @moduledoc """
  Automatically generated by xdrgen
  DO NOT EDIT or your changes may be overwritten

  Target implementation: elixir_xdr at https://hex.pm/packages/elixir_xdr

  Representation of Stellar `StateArchivalSettings` type.
  """

  @behaviour XDR.Declaration

  alias StellarBase.XDR.{
    UInt32,
    Int64
  }

  @struct_spec XDR.Struct.new(
                 max_entry_ttl: UInt32,
                 min_temporary_ttl: UInt32,
                 min_persistent_ttl: UInt32,
                 persistent_rent_rate_denominator: Int64,
                 temp_rent_rate_denominator: Int64,
                 max_entries_to_archive: UInt32,
                 bucket_list_size_window_sample_size: UInt32,
                 bucket_list_window_sample_period: UInt32,
                 eviction_scan_size: UInt32,
                 starting_eviction_scan_level: UInt32
               )

  @type max_entry_ttl_type :: UInt32.t()
  @type min_temporary_ttl_type :: UInt32.t()
  @type min_persistent_ttl_type :: UInt32.t()
  @type persistent_rent_rate_denominator_type :: Int64.t()
  @type temp_rent_rate_denominator_type :: Int64.t()
  @type max_entries_to_archive_type :: UInt32.t()
  @type bucket_list_size_window_sample_size_type :: UInt32.t()
  @type bucket_list_window_sample_period_type :: UInt32.t()
  @type eviction_scan_size_type :: UInt32.t()
  @type starting_eviction_scan_level_type :: UInt32.t()

  @type t :: %__MODULE__{
          max_entry_ttl: max_entry_ttl_type(),
          min_temporary_ttl: min_temporary_ttl_type(),
          min_persistent_ttl: min_persistent_ttl_type(),
          persistent_rent_rate_denominator: persistent_rent_rate_denominator_type(),
          temp_rent_rate_denominator: temp_rent_rate_denominator_type(),
          max_entries_to_archive: max_entries_to_archive_type(),
          bucket_list_size_window_sample_size: bucket_list_size_window_sample_size_type(),
          bucket_list_window_sample_period: bucket_list_window_sample_period_type(),
          eviction_scan_size: eviction_scan_size_type(),
          starting_eviction_scan_level: starting_eviction_scan_level_type()
        }

  defstruct [
    :max_entry_ttl,
    :min_temporary_ttl,
    :min_persistent_ttl,
    :persistent_rent_rate_denominator,
    :temp_rent_rate_denominator,
    :max_entries_to_archive,
    :bucket_list_size_window_sample_size,
    :bucket_list_window_sample_period,
    :eviction_scan_size,
    :starting_eviction_scan_level
  ]

  @spec new(
          max_entry_ttl :: max_entry_ttl_type(),
          min_temporary_ttl :: min_temporary_ttl_type(),
          min_persistent_ttl :: min_persistent_ttl_type(),
          persistent_rent_rate_denominator :: persistent_rent_rate_denominator_type(),
          temp_rent_rate_denominator :: temp_rent_rate_denominator_type(),
          max_entries_to_archive :: max_entries_to_archive_type(),
          bucket_list_size_window_sample_size :: bucket_list_size_window_sample_size_type(),
          bucket_list_window_sample_period :: bucket_list_window_sample_period_type(),
          eviction_scan_size :: eviction_scan_size_type(),
          starting_eviction_scan_level :: starting_eviction_scan_level_type()
        ) :: t()
  def new(
        %UInt32{} = max_entry_ttl,
        %UInt32{} = min_temporary_ttl,
        %UInt32{} = min_persistent_ttl,
        %Int64{} = persistent_rent_rate_denominator,
        %Int64{} = temp_rent_rate_denominator,
        %UInt32{} = max_entries_to_archive,
        %UInt32{} = bucket_list_size_window_sample_size,
        %UInt32{} = bucket_list_window_sample_period,
        %UInt32{} = eviction_scan_size,
        %UInt32{} = starting_eviction_scan_level
      ),
      do: %__MODULE__{
        max_entry_ttl: max_entry_ttl,
        min_temporary_ttl: min_temporary_ttl,
        min_persistent_ttl: min_persistent_ttl,
        persistent_rent_rate_denominator: persistent_rent_rate_denominator,
        temp_rent_rate_denominator: temp_rent_rate_denominator,
        max_entries_to_archive: max_entries_to_archive,
        bucket_list_size_window_sample_size: bucket_list_size_window_sample_size,
        bucket_list_window_sample_period: bucket_list_window_sample_period,
        eviction_scan_size: eviction_scan_size,
        starting_eviction_scan_level: starting_eviction_scan_level
      }

  @impl true
  def encode_xdr(%__MODULE__{
        max_entry_ttl: max_entry_ttl,
        min_temporary_ttl: min_temporary_ttl,
        min_persistent_ttl: min_persistent_ttl,
        persistent_rent_rate_denominator: persistent_rent_rate_denominator,
        temp_rent_rate_denominator: temp_rent_rate_denominator,
        max_entries_to_archive: max_entries_to_archive,
        bucket_list_size_window_sample_size: bucket_list_size_window_sample_size,
        bucket_list_window_sample_period: bucket_list_window_sample_period,
        eviction_scan_size: eviction_scan_size,
        starting_eviction_scan_level: starting_eviction_scan_level
      }) do
    [
      max_entry_ttl: max_entry_ttl,
      min_temporary_ttl: min_temporary_ttl,
      min_persistent_ttl: min_persistent_ttl,
      persistent_rent_rate_denominator: persistent_rent_rate_denominator,
      temp_rent_rate_denominator: temp_rent_rate_denominator,
      max_entries_to_archive: max_entries_to_archive,
      bucket_list_size_window_sample_size: bucket_list_size_window_sample_size,
      bucket_list_window_sample_period: bucket_list_window_sample_period,
      eviction_scan_size: eviction_scan_size,
      starting_eviction_scan_level: starting_eviction_scan_level
    ]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{
        max_entry_ttl: max_entry_ttl,
        min_temporary_ttl: min_temporary_ttl,
        min_persistent_ttl: min_persistent_ttl,
        persistent_rent_rate_denominator: persistent_rent_rate_denominator,
        temp_rent_rate_denominator: temp_rent_rate_denominator,
        max_entries_to_archive: max_entries_to_archive,
        bucket_list_size_window_sample_size: bucket_list_size_window_sample_size,
        bucket_list_window_sample_period: bucket_list_window_sample_period,
        eviction_scan_size: eviction_scan_size,
        starting_eviction_scan_level: starting_eviction_scan_level
      }) do
    [
      max_entry_ttl: max_entry_ttl,
      min_temporary_ttl: min_temporary_ttl,
      min_persistent_ttl: min_persistent_ttl,
      persistent_rent_rate_denominator: persistent_rent_rate_denominator,
      temp_rent_rate_denominator: temp_rent_rate_denominator,
      max_entries_to_archive: max_entries_to_archive,
      bucket_list_size_window_sample_size: bucket_list_size_window_sample_size,
      bucket_list_window_sample_period: bucket_list_window_sample_period,
      eviction_scan_size: eviction_scan_size,
      starting_eviction_scan_level: starting_eviction_scan_level
    ]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok,
       {%XDR.Struct{
          components: [
            max_entry_ttl: max_entry_ttl,
            min_temporary_ttl: min_temporary_ttl,
            min_persistent_ttl: min_persistent_ttl,
            persistent_rent_rate_denominator: persistent_rent_rate_denominator,
            temp_rent_rate_denominator: temp_rent_rate_denominator,
            max_entries_to_archive: max_entries_to_archive,
            bucket_list_size_window_sample_size: bucket_list_size_window_sample_size,
            bucket_list_window_sample_period: bucket_list_window_sample_period,
            eviction_scan_size: eviction_scan_size,
            starting_eviction_scan_level: starting_eviction_scan_level
          ]
        }, rest}} ->
        {:ok,
         {new(
            max_entry_ttl,
            min_temporary_ttl,
            min_persistent_ttl,
            persistent_rent_rate_denominator,
            temp_rent_rate_denominator,
            max_entries_to_archive,
            bucket_list_size_window_sample_size,
            bucket_list_window_sample_period,
            eviction_scan_size,
            starting_eviction_scan_level
          ), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{
       components: [
         max_entry_ttl: max_entry_ttl,
         min_temporary_ttl: min_temporary_ttl,
         min_persistent_ttl: min_persistent_ttl,
         persistent_rent_rate_denominator: persistent_rent_rate_denominator,
         temp_rent_rate_denominator: temp_rent_rate_denominator,
         max_entries_to_archive: max_entries_to_archive,
         bucket_list_size_window_sample_size: bucket_list_size_window_sample_size,
         bucket_list_window_sample_period: bucket_list_window_sample_period,
         eviction_scan_size: eviction_scan_size,
         starting_eviction_scan_level: starting_eviction_scan_level
       ]
     }, rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(
       max_entry_ttl,
       min_temporary_ttl,
       min_persistent_ttl,
       persistent_rent_rate_denominator,
       temp_rent_rate_denominator,
       max_entries_to_archive,
       bucket_list_size_window_sample_size,
       bucket_list_window_sample_period,
       eviction_scan_size,
       starting_eviction_scan_level
     ), rest}
  end
end
