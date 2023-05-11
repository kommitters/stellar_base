defmodule StellarBase.XDR.UpgradeEntryMeta do
  @moduledoc """
  Automatically generated by xdrgen
  DO NOT EDIT or your changes may be overwritten

  Target implementation: elixir_xdr at https://hex.pm/packages/elixir_xdr

  Representation of Stellar `UpgradeEntryMeta` type.
  """

  @behaviour XDR.Declaration

  alias StellarBase.XDR.{
    LedgerUpgrade,
    LedgerEntryChanges
  }

  @struct_spec XDR.Struct.new(
    upgrade: LedgerUpgrade,
    changes: LedgerEntryChanges
  )

  @type type_upgrade :: LedgerUpgrade.t()
  @type type_changes :: LedgerEntryChanges.t()

  @type t :: %__MODULE__{upgrade: type_upgrade(), changes: type_changes()}

  defstruct [:upgrade, :changes]

  @spec new(upgrade :: type_upgrade(), changes :: type_changes()) :: t()
  def new(
    %LedgerUpgrade{} = upgrade,
    %LedgerEntryChanges{} = changes
  ),
  do: %__MODULE__{upgrade: upgrade, changes: changes}

  @impl true
  def encode_xdr(%__MODULE__{upgrade: upgrade, changes: changes}) do
    [upgrade: upgrade, changes: changes]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{upgrade: upgrade, changes: changes}) do
    [upgrade: upgrade, changes: changes]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, struct \\ @struct_spec)

  def decode_xdr(bytes, struct) do
    case XDR.Struct.decode_xdr(bytes, struct) do
      {:ok, {%XDR.Struct{components: [upgrade: upgrade, changes: changes]}, rest}} ->
        {:ok, {new(upgrade, changes), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{components: [upgrade: upgrade, changes: changes]}, rest} =
      XDR.Struct.decode_xdr!(bytes, struct)
    {new(upgrade, changes), rest}
  end
end
