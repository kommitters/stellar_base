defmodule StellarBase.XDR.SCPNomination do
  @moduledoc """
  Automatically generated by xdrgen
  DO NOT EDIT or your changes may be overwritten

  Target implementation: elixir_xdr at https://hex.pm/packages/elixir_xdr

  Representation of Stellar `SCPNomination` type.
  """

  @behaviour XDR.Declaration

  alias StellarBase.XDR.{
    Hash,
    ValueList
  }

  @struct_spec XDR.Struct.new(
    quorum_set_hash: Hash,
    votes: ValueList,
    accepted: ValueList
  )

  @type type_quorum_set_hash :: Hash.t()
  @type type_votes :: ValueList.t()
  @type type_accepted :: ValueList.t()

  @type t :: %__MODULE__{quorum_set_hash: type_quorum_set_hash(), votes: type_votes(), accepted: type_accepted()}

  defstruct [:quorum_set_hash, :votes, :accepted]

  @spec new(quorum_set_hash :: type_quorum_set_hash(), votes :: type_votes(), accepted :: type_accepted()) :: t()
  def new(
    %Hash{} = quorum_set_hash,
    %ValueList{} = votes,
    %ValueList{} = accepted
  ),
  do: %__MODULE__{quorum_set_hash: quorum_set_hash, votes: votes, accepted: accepted}

  @impl true
  def encode_xdr(%__MODULE__{quorum_set_hash: quorum_set_hash, votes: votes, accepted: accepted}) do
    [quorum_set_hash: quorum_set_hash, votes: votes, accepted: accepted]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{quorum_set_hash: quorum_set_hash, votes: votes, accepted: accepted}) do
    [quorum_set_hash: quorum_set_hash, votes: votes, accepted: accepted]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [quorum_set_hash: quorum_set_hash, votes: votes, accepted: accepted]}, rest}} ->
        {:ok, {new(quorum_set_hash, votes, accepted), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [quorum_set_hash: quorum_set_hash, votes: votes, accepted: accepted]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)
    {new(quorum_set_hash, votes, accepted), rest}
  end
end
