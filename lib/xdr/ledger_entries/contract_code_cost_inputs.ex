defmodule StellarBase.XDR.ContractCodeCostInputs do
  @moduledoc """
  Automatically generated by xdrgen
  DO NOT EDIT or your changes may be overwritten

  Target implementation: elixir_xdr at https://hex.pm/packages/elixir_xdr

  Representation of Stellar `ContractCodeCostInputs` type.
  """

  @behaviour XDR.Declaration

  alias StellarBase.XDR.{
    ExtensionPoint,
    UInt32
  }

  @struct_spec XDR.Struct.new(
                 ext: ExtensionPoint,
                 n_instructions: UInt32,
                 n_functions: UInt32,
                 n_globals: UInt32,
                 n_table_entries: UInt32,
                 n_types: UInt32,
                 n_data_segments: UInt32,
                 n_elem_segments: UInt32,
                 n_imports: UInt32,
                 n_exports: UInt32,
                 n_data_segment_bytes: UInt32
               )

  @type ext_type :: ExtensionPoint.t()
  @type n_instructions_type :: UInt32.t()
  @type n_functions_type :: UInt32.t()
  @type n_globals_type :: UInt32.t()
  @type n_table_entries_type :: UInt32.t()
  @type n_types_type :: UInt32.t()
  @type n_data_segments_type :: UInt32.t()
  @type n_elem_segments_type :: UInt32.t()
  @type n_imports_type :: UInt32.t()
  @type n_exports_type :: UInt32.t()
  @type n_data_segment_bytes_type :: UInt32.t()

  @type t :: %__MODULE__{
          ext: ext_type(),
          n_instructions: n_instructions_type(),
          n_functions: n_functions_type(),
          n_globals: n_globals_type(),
          n_table_entries: n_table_entries_type(),
          n_types: n_types_type(),
          n_data_segments: n_data_segments_type(),
          n_elem_segments: n_elem_segments_type(),
          n_imports: n_imports_type(),
          n_exports: n_exports_type(),
          n_data_segment_bytes: n_data_segment_bytes_type()
        }

  defstruct [
    :ext,
    :n_instructions,
    :n_functions,
    :n_globals,
    :n_table_entries,
    :n_types,
    :n_data_segments,
    :n_elem_segments,
    :n_imports,
    :n_exports,
    :n_data_segment_bytes
  ]

  @spec new(
          ext :: ext_type(),
          n_instructions :: n_instructions_type(),
          n_functions :: n_functions_type(),
          n_globals :: n_globals_type(),
          n_table_entries :: n_table_entries_type(),
          n_types :: n_types_type(),
          n_data_segments :: n_data_segments_type(),
          n_elem_segments :: n_elem_segments_type(),
          n_imports :: n_imports_type(),
          n_exports :: n_exports_type(),
          n_data_segment_bytes :: n_data_segment_bytes_type()
        ) :: t()
  def new(
        %ExtensionPoint{} = ext,
        %UInt32{} = n_instructions,
        %UInt32{} = n_functions,
        %UInt32{} = n_globals,
        %UInt32{} = n_table_entries,
        %UInt32{} = n_types,
        %UInt32{} = n_data_segments,
        %UInt32{} = n_elem_segments,
        %UInt32{} = n_imports,
        %UInt32{} = n_exports,
        %UInt32{} = n_data_segment_bytes
      ),
      do: %__MODULE__{
        ext: ext,
        n_instructions: n_instructions,
        n_functions: n_functions,
        n_globals: n_globals,
        n_table_entries: n_table_entries,
        n_types: n_types,
        n_data_segments: n_data_segments,
        n_elem_segments: n_elem_segments,
        n_imports: n_imports,
        n_exports: n_exports,
        n_data_segment_bytes: n_data_segment_bytes
      }

  @impl true
  def encode_xdr(%__MODULE__{
        ext: ext,
        n_instructions: n_instructions,
        n_functions: n_functions,
        n_globals: n_globals,
        n_table_entries: n_table_entries,
        n_types: n_types,
        n_data_segments: n_data_segments,
        n_elem_segments: n_elem_segments,
        n_imports: n_imports,
        n_exports: n_exports,
        n_data_segment_bytes: n_data_segment_bytes
      }) do
    [
      ext: ext,
      n_instructions: n_instructions,
      n_functions: n_functions,
      n_globals: n_globals,
      n_table_entries: n_table_entries,
      n_types: n_types,
      n_data_segments: n_data_segments,
      n_elem_segments: n_elem_segments,
      n_imports: n_imports,
      n_exports: n_exports,
      n_data_segment_bytes: n_data_segment_bytes
    ]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{
        ext: ext,
        n_instructions: n_instructions,
        n_functions: n_functions,
        n_globals: n_globals,
        n_table_entries: n_table_entries,
        n_types: n_types,
        n_data_segments: n_data_segments,
        n_elem_segments: n_elem_segments,
        n_imports: n_imports,
        n_exports: n_exports,
        n_data_segment_bytes: n_data_segment_bytes
      }) do
    [
      ext: ext,
      n_instructions: n_instructions,
      n_functions: n_functions,
      n_globals: n_globals,
      n_table_entries: n_table_entries,
      n_types: n_types,
      n_data_segments: n_data_segments,
      n_elem_segments: n_elem_segments,
      n_imports: n_imports,
      n_exports: n_exports,
      n_data_segment_bytes: n_data_segment_bytes
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
            ext: ext,
            n_instructions: n_instructions,
            n_functions: n_functions,
            n_globals: n_globals,
            n_table_entries: n_table_entries,
            n_types: n_types,
            n_data_segments: n_data_segments,
            n_elem_segments: n_elem_segments,
            n_imports: n_imports,
            n_exports: n_exports,
            n_data_segment_bytes: n_data_segment_bytes
          ]
        }, rest}} ->
        {:ok,
         {new(
            ext,
            n_instructions,
            n_functions,
            n_globals,
            n_table_entries,
            n_types,
            n_data_segments,
            n_elem_segments,
            n_imports,
            n_exports,
            n_data_segment_bytes
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
         ext: ext,
         n_instructions: n_instructions,
         n_functions: n_functions,
         n_globals: n_globals,
         n_table_entries: n_table_entries,
         n_types: n_types,
         n_data_segments: n_data_segments,
         n_elem_segments: n_elem_segments,
         n_imports: n_imports,
         n_exports: n_exports,
         n_data_segment_bytes: n_data_segment_bytes
       ]
     }, rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(
       ext,
       n_instructions,
       n_functions,
       n_globals,
       n_table_entries,
       n_types,
       n_data_segments,
       n_elem_segments,
       n_imports,
       n_exports,
       n_data_segment_bytes
     ), rest}
  end
end
