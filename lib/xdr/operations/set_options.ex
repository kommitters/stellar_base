defmodule Stellar.XDR.Operations.SetOptions do
  @moduledoc """
  Representation of Stellar `SetOptions` type.
  """
  alias Stellar.XDR.{OptionalAccountID, OptionalUInt32, OptionalString32, Signer}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(
                 inflation_dest: OptionalAccountID,
                 clear_flags: OptionalUInt32,
                 set_flags: OptionalUInt32,
                 master_weight: OptionalUInt32,
                 low_threshold: OptionalUInt32,
                 med_threshold: OptionalUInt32,
                 high_threshold: OptionalUInt32,
                 home_domain: OptionalString32,
                 signer: Signer
               )

  @type t :: %__MODULE__{
          inflation_dest: OptionalAccountID.t(),
          clear_flags: OptionalUInt32.t(),
          set_flags: OptionalUInt32.t(),
          master_weight: OptionalUInt32.t(),
          low_threshold: OptionalUInt32.t(),
          med_threshold: OptionalUInt32.t(),
          high_threshold: OptionalUInt32.t(),
          home_domain: OptionalString32.t(),
          signer: Signer.t()
        }

  defstruct [
    :inflation_dest,
    :clear_flags,
    :set_flags,
    :master_weight,
    :low_threshold,
    :med_threshold,
    :high_threshold,
    :home_domain,
    :signer
  ]

  @spec new(
          inflation_dest :: OptionalAccountID.t(),
          clear_flags :: OptionalUInt32.t(),
          set_flags :: OptionalUInt32.t(),
          master_weight :: OptionalUInt32.t(),
          low_threshold :: OptionalUInt32.t(),
          med_threshold :: OptionalUInt32.t(),
          high_threshold :: OptionalUInt32.t(),
          home_domain :: OptionalString32.t(),
          signer :: Signer.t()
        ) :: t()
  def new(
        %OptionalAccountID{} = inflation_dest,
        %OptionalUInt32{} = clear_flags,
        %OptionalUInt32{} = set_flags,
        %OptionalUInt32{} = master_weight,
        %OptionalUInt32{} = low_threshold,
        %OptionalUInt32{} = med_threshold,
        %OptionalUInt32{} = high_threshold,
        %OptionalString32{} = home_domain,
        %Signer{} = signer
      ),
      do: %__MODULE__{
        inflation_dest: inflation_dest,
        clear_flags: clear_flags,
        set_flags: set_flags,
        master_weight: master_weight,
        low_threshold: low_threshold,
        med_threshold: med_threshold,
        high_threshold: high_threshold,
        home_domain: home_domain,
        signer: signer
      }

  @impl true
  def encode_xdr(%__MODULE__{
        inflation_dest: inflation_dest,
        clear_flags: clear_flags,
        set_flags: set_flags,
        master_weight: master_weight,
        low_threshold: low_threshold,
        med_threshold: med_threshold,
        high_threshold: high_threshold,
        home_domain: home_domain,
        signer: signer
      }) do
    [
      inflation_dest: inflation_dest,
      clear_flags: clear_flags,
      set_flags: set_flags,
      master_weight: master_weight,
      low_threshold: low_threshold,
      med_threshold: med_threshold,
      high_threshold: high_threshold,
      home_domain: home_domain,
      signer: signer
    ]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{
        inflation_dest: inflation_dest,
        clear_flags: clear_flags,
        set_flags: set_flags,
        master_weight: master_weight,
        low_threshold: low_threshold,
        med_threshold: med_threshold,
        high_threshold: high_threshold,
        home_domain: home_domain,
        signer: signer
      }) do
    [
      inflation_dest: inflation_dest,
      clear_flags: clear_flags,
      set_flags: set_flags,
      master_weight: master_weight,
      low_threshold: low_threshold,
      med_threshold: med_threshold,
      high_threshold: high_threshold,
      home_domain: home_domain,
      signer: signer
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
            inflation_dest: inflation_dest,
            clear_flags: clear_flags,
            set_flags: set_flags,
            master_weight: master_weight,
            low_threshold: low_threshold,
            med_threshold: med_threshold,
            high_threshold: high_threshold,
            home_domain: home_domain,
            signer: signer
          ]
        }, rest}} ->
        {:ok,
         {new(
            inflation_dest,
            clear_flags,
            set_flags,
            master_weight,
            low_threshold,
            med_threshold,
            high_threshold,
            home_domain,
            signer
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
         inflation_dest: inflation_dest,
         clear_flags: clear_flags,
         set_flags: set_flags,
         master_weight: master_weight,
         low_threshold: low_threshold,
         med_threshold: med_threshold,
         high_threshold: high_threshold,
         home_domain: home_domain,
         signer: signer
       ]
     }, rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(
       inflation_dest,
       clear_flags,
       set_flags,
       master_weight,
       low_threshold,
       med_threshold,
       high_threshold,
       home_domain,
       signer
     ), rest}
  end
end
