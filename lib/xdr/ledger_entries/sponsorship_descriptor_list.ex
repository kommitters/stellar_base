defmodule StellarBase.XDR.SponsorshipDescriptorList do
  @moduledoc """
  Representation of a Stellar `SponsorshipDescriptor` list.
  """

  alias StellarBase.XDR.SponsorshipDescriptor

  @behaviour XDR.Declaration

  @max_length 20

  @array_type SponsorshipDescriptor

  @array_spec %{type: @array_type, max_length: @max_length}

  @type t :: %__MODULE__{sponsorship_descriptors: list(SponsorshipDescriptor.t())}

  defstruct [:sponsorship_descriptors]

  @spec new(sponsorship_descriptors :: list(SponsorshipDescriptor.t())) :: t()
  def new(sponsorship_descriptors),
    do: %__MODULE__{sponsorship_descriptors: sponsorship_descriptors}

  @impl true
  def encode_xdr(%__MODULE__{sponsorship_descriptors: sponsorship_descriptors}) do
    sponsorship_descriptors
    |> XDR.VariableArray.new(@array_type, @max_length)
    |> XDR.VariableArray.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{sponsorship_descriptors: sponsorship_descriptors}) do
    sponsorship_descriptors
    |> XDR.VariableArray.new(@array_type, @max_length)
    |> XDR.VariableArray.encode_xdr!()
  end

  @impl true
  def decode_xdr(bytes, spec \\ @array_spec)

  def decode_xdr(bytes, spec) do
    case XDR.VariableArray.decode_xdr(bytes, spec) do
      {:ok, {sponsorship_descriptors, rest}} -> {:ok, {new(sponsorship_descriptors), rest}}
      error -> error
    end
  end

  @impl true
  def decode_xdr!(bytes, spec \\ @array_spec)

  def decode_xdr!(bytes, spec) do
    {sponsorship_descriptors, rest} = XDR.VariableArray.decode_xdr!(bytes, spec)
    {new(sponsorship_descriptors), rest}
  end
end
