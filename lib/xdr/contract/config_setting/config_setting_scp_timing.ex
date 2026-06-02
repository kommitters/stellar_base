defmodule StellarBase.XDR.ConfigSettingSCPTiming do
  @moduledoc """
  Representation of Stellar `ConfigSettingSCPTiming` type.
  """

  @behaviour XDR.Declaration

  alias StellarBase.XDR.UInt32

  @struct_spec XDR.Struct.new(
                 ledger_target_close_time_milliseconds: UInt32,
                 nomination_timeout_initial_milliseconds: UInt32,
                 nomination_timeout_increment_milliseconds: UInt32,
                 ballot_timeout_initial_milliseconds: UInt32,
                 ballot_timeout_increment_milliseconds: UInt32
               )

  @type ledger_target_close_time_milliseconds_type :: UInt32.t()
  @type nomination_timeout_initial_milliseconds_type :: UInt32.t()
  @type nomination_timeout_increment_milliseconds_type :: UInt32.t()
  @type ballot_timeout_initial_milliseconds_type :: UInt32.t()
  @type ballot_timeout_increment_milliseconds_type :: UInt32.t()

  @type t :: %__MODULE__{
          ledger_target_close_time_milliseconds: ledger_target_close_time_milliseconds_type(),
          nomination_timeout_initial_milliseconds: nomination_timeout_initial_milliseconds_type(),
          nomination_timeout_increment_milliseconds:
            nomination_timeout_increment_milliseconds_type(),
          ballot_timeout_initial_milliseconds: ballot_timeout_initial_milliseconds_type(),
          ballot_timeout_increment_milliseconds: ballot_timeout_increment_milliseconds_type()
        }

  defstruct [
    :ledger_target_close_time_milliseconds,
    :nomination_timeout_initial_milliseconds,
    :nomination_timeout_increment_milliseconds,
    :ballot_timeout_initial_milliseconds,
    :ballot_timeout_increment_milliseconds
  ]

  @spec new(
          ledger_target_close_time_milliseconds :: ledger_target_close_time_milliseconds_type(),
          nomination_timeout_initial_milliseconds ::
            nomination_timeout_initial_milliseconds_type(),
          nomination_timeout_increment_milliseconds ::
            nomination_timeout_increment_milliseconds_type(),
          ballot_timeout_initial_milliseconds :: ballot_timeout_initial_milliseconds_type(),
          ballot_timeout_increment_milliseconds :: ballot_timeout_increment_milliseconds_type()
        ) :: t()
  def new(
        %UInt32{} = ledger_target_close_time_milliseconds,
        %UInt32{} = nomination_timeout_initial_milliseconds,
        %UInt32{} = nomination_timeout_increment_milliseconds,
        %UInt32{} = ballot_timeout_initial_milliseconds,
        %UInt32{} = ballot_timeout_increment_milliseconds
      ),
      do: %__MODULE__{
        ledger_target_close_time_milliseconds: ledger_target_close_time_milliseconds,
        nomination_timeout_initial_milliseconds: nomination_timeout_initial_milliseconds,
        nomination_timeout_increment_milliseconds: nomination_timeout_increment_milliseconds,
        ballot_timeout_initial_milliseconds: ballot_timeout_initial_milliseconds,
        ballot_timeout_increment_milliseconds: ballot_timeout_increment_milliseconds
      }

  @impl true
  def encode_xdr(%__MODULE__{
        ledger_target_close_time_milliseconds: ledger_target_close_time_milliseconds,
        nomination_timeout_initial_milliseconds: nomination_timeout_initial_milliseconds,
        nomination_timeout_increment_milliseconds: nomination_timeout_increment_milliseconds,
        ballot_timeout_initial_milliseconds: ballot_timeout_initial_milliseconds,
        ballot_timeout_increment_milliseconds: ballot_timeout_increment_milliseconds
      }) do
    [
      ledger_target_close_time_milliseconds: ledger_target_close_time_milliseconds,
      nomination_timeout_initial_milliseconds: nomination_timeout_initial_milliseconds,
      nomination_timeout_increment_milliseconds: nomination_timeout_increment_milliseconds,
      ballot_timeout_initial_milliseconds: ballot_timeout_initial_milliseconds,
      ballot_timeout_increment_milliseconds: ballot_timeout_increment_milliseconds
    ]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{
        ledger_target_close_time_milliseconds: ledger_target_close_time_milliseconds,
        nomination_timeout_initial_milliseconds: nomination_timeout_initial_milliseconds,
        nomination_timeout_increment_milliseconds: nomination_timeout_increment_milliseconds,
        ballot_timeout_initial_milliseconds: ballot_timeout_initial_milliseconds,
        ballot_timeout_increment_milliseconds: ballot_timeout_increment_milliseconds
      }) do
    [
      ledger_target_close_time_milliseconds: ledger_target_close_time_milliseconds,
      nomination_timeout_initial_milliseconds: nomination_timeout_initial_milliseconds,
      nomination_timeout_increment_milliseconds: nomination_timeout_increment_milliseconds,
      ballot_timeout_initial_milliseconds: ballot_timeout_initial_milliseconds,
      ballot_timeout_increment_milliseconds: ballot_timeout_increment_milliseconds
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
            ledger_target_close_time_milliseconds: ledger_target_close_time_milliseconds,
            nomination_timeout_initial_milliseconds: nomination_timeout_initial_milliseconds,
            nomination_timeout_increment_milliseconds: nomination_timeout_increment_milliseconds,
            ballot_timeout_initial_milliseconds: ballot_timeout_initial_milliseconds,
            ballot_timeout_increment_milliseconds: ballot_timeout_increment_milliseconds
          ]
        }, rest}} ->
        {:ok,
         {new(
            ledger_target_close_time_milliseconds,
            nomination_timeout_initial_milliseconds,
            nomination_timeout_increment_milliseconds,
            ballot_timeout_initial_milliseconds,
            ballot_timeout_increment_milliseconds
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
         ledger_target_close_time_milliseconds: ledger_target_close_time_milliseconds,
         nomination_timeout_initial_milliseconds: nomination_timeout_initial_milliseconds,
         nomination_timeout_increment_milliseconds: nomination_timeout_increment_milliseconds,
         ballot_timeout_initial_milliseconds: ballot_timeout_initial_milliseconds,
         ballot_timeout_increment_milliseconds: ballot_timeout_increment_milliseconds
       ]
     }, rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(
       ledger_target_close_time_milliseconds,
       nomination_timeout_initial_milliseconds,
       nomination_timeout_increment_milliseconds,
       ballot_timeout_initial_milliseconds,
       ballot_timeout_increment_milliseconds
     ), rest}
  end
end
