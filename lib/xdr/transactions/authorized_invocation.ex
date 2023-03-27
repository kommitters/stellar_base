defmodule StellarBase.XDR.AuthorizedInvocation do
  @moduledoc """
  Representation of Stellar `AuthorizedInvocation` type.
  """

  alias StellarBase.XDR.{Hash, SCSymbol, SCVec, AuthorizedInvocationList}

  @behaviour XDR.Declaration

  @struct_spec XDR.Struct.new(
                 contract_id: Hash,
                 function_name: SCSymbol,
                 args: SCVec,
                 sub_invocations: AuthorizedInvocationList
               )

  @type contract_id :: Hash.t()
  @type function_name :: SCSymbol.t()
  @type args :: SCVec.t()
  @type sub_invocations :: AuthorizedInvocationList.t()

  @type t :: %__MODULE__{
          contract_id: contract_id(),
          function_name: function_name(),
          args: args(),
          sub_invocations: sub_invocations()
        }

  defstruct [:contract_id, :function_name, :args, :sub_invocations]

  @spec new(
          contract_id :: contract_id(),
          function_name :: function_name(),
          args :: args(),
          sub_invocations :: sub_invocations()
        ) :: t()
  def new(
        %Hash{} = contract_id,
        %SCSymbol{} = function_name,
        %SCVec{} = args,
        %AuthorizedInvocationList{} = sub_invocations
      ),
      do: %__MODULE__{
        contract_id: contract_id,
        function_name: function_name,
        args: args,
        sub_invocations: sub_invocations
      }

  @impl true
  def encode_xdr(%__MODULE__{
        contract_id: contract_id,
        function_name: function_name,
        args: args,
        sub_invocations: sub_invocations
      }) do
    [
      contract_id: contract_id,
      function_name: function_name,
      args: args,
      sub_invocations: sub_invocations
    ]
    |> XDR.Struct.new()
    |> XDR.Struct.encode_xdr()
  end

  @impl true
  def encode_xdr!(%__MODULE__{
        contract_id: contract_id,
        function_name: function_name,
        args: args,
        sub_invocations: sub_invocations
      }) do
    [
      contract_id: contract_id,
      function_name: function_name,
      args: args,
      sub_invocations: sub_invocations
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
            contract_id: contract_id,
            function_name: function_name,
            args: args,
            sub_invocations: sub_invocations
          ]
        }, rest}} ->
        {:ok, {new(contract_id, function_name, args, sub_invocations), rest}}

      error ->
        error
    end
  end

  @impl true
  def decode_xdr!(bytes, struct \\ @struct_spec)

  def decode_xdr!(bytes, struct) do
    {%XDR.Struct{
       components: [
         contract_id: contract_id,
         function_name: function_name,
         args: args,
         sub_invocations: sub_invocations
       ]
     }, rest} = XDR.Struct.decode_xdr!(bytes, struct)

    {new(contract_id, function_name, args, sub_invocations), rest}
  end
end
