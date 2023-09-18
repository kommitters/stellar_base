defmodule StellarBase.XDR.EvictionIterator do
  @moduledoc """
  Automatically generated by xdrgen
  DO NOT EDIT or your changes may be overwritten
  Target implementation: elixir_xdr at https://hex.pm/packages/elixir_xdr
  Representation of Stellar `EvictionIterator` type.
  """

  @behaviour XDR.Declaration

  alias StellarBase.XDR.{
    Bool,
    UInt32,
    UInt64
  }

  @struct_spec XDR.Struct.new(
                 bucket_list_level: UInt32,
                 is_curr_bucket: Bool,
                 bucket_file_offset: UInt64
               )

  @type bucket_list_level_type :: UInt32.t()
  @type is_curr_bucket_type :: Bool.t()
  @type bucket_file_offset_type :: UInt64.t()

  @type t :: %__MODULE__{
          bucket_list_level: bucket_list_level_type(),
          is_curr_bucket: is_curr_bucket_type(),
          bucket_file_offset: bucket_file_offset_type()
        }

  defstruct [:bucket_list_level, :is_curr_bucket, :bucket_file_offset]

  @spec new(
          bucket_list_level :: bucket_list_level_type(),
          is_curr_bucket :: is_curr_bucket_type(),
          bucket_file_offset :: bucket_file_offset_type()
        ) :: t()
  def new(
        %UInt32{} = bucket_list_level,
        %Bool{} = is_curr_bucket,
        %UInt64{} = bucket_file_offset
      ),
      do: %__MODULE__{
        bucket_list_level: bucket_list_level,
        is_curr_bucket: is_curr_bucket,
        bucket_file_offset: bucket_file_offset
      }

  @impl true
  def encode_xdr(%__MODULE__{
        bucket_list_level: bucket_list_level,
        is_curr_bucket: is_curr_bucket,
        bucket_file_offset: bucket_file_offset
      }) do
    [
      bucket_list_level: bucket_list_level,
      is_curr_bucket: is_curr_bucket,
      bucket_file_offset: bucket_file_offset
    ]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{
        bucket_list_level: bucket_list_level,
        is_curr_bucket: is_curr_bucket,
        bucket_file_offset: bucket_file_offset
      }) do
    [
      bucket_list_level: bucket_list_level,
      is_curr_bucket: is_curr_bucket,
      bucket_file_offset: bucket_file_offset
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
            bucket_list_level: bucket_list_level,
            is_curr_bucket: is_curr_bucket,
            bucket_file_offset: bucket_file_offset
          ]
        }, rest}} ->
        {:ok, {new(bucket_list_level, is_curr_bucket, bucket_file_offset), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{
       components: [
         bucket_list_level: bucket_list_level,
         is_curr_bucket: is_curr_bucket,
         bucket_file_offset: bucket_file_offset
       ]
     }, rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(bucket_list_level, is_curr_bucket, bucket_file_offset), rest}
  end
end
