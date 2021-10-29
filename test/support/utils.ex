defmodule Stellar.Test.Utils do
  @moduledoc """
  Utils functions for test constructions.
  """
  alias Stellar.XDR.{
    AccountID,
    AlphaNum12,
    AlphaNum4,
    Asset,
    AssetCode12,
    AssetCode4,
    AssetType,
    CryptoKeyType,
    DecoratedSignature,
    DecoratedSignatures,
    MuxedAccount,
    OperationBody,
    OperationType,
    PublicKey,
    PublicKeyType,
    Signature,
    SignatureHint,
    UInt256
  }

  alias Stellar.XDR.Operations.{Payment, Clawback}

  @spec ed25519_public_key(pk_key :: binary()) :: UInt256.t()
  def ed25519_public_key(pk_key) do
    pk_key
    |> Stellar.Ed25519.PublicKey.decode!()
    |> UInt256.new()
  end

  @spec create_account_id(pk_key :: binary()) :: AccountID.t()
  def create_account_id(pk_key) do
    key_type = PublicKeyType.new(:PUBLIC_KEY_TYPE_ED25519)

    pk_key
    |> Stellar.Ed25519.PublicKey.decode!()
    |> UInt256.new()
    |> PublicKey.new(key_type)
    |> AccountID.new()
  end

  @spec create_muxed_account(pk_key :: binary()) :: MuxedAccount.t()
  def create_muxed_account(pk_key) do
    key_type = CryptoKeyType.new(:KEY_TYPE_ED25519)

    pk_key
    |> Stellar.Ed25519.PublicKey.decode!()
    |> UInt256.new()
    |> MuxedAccount.new(key_type)
  end

  @spec create_asset(type :: atom(), attributes :: Keyword.t()) :: Asset.t()
  def create_asset(:alpha_num4, code: code, issuer: issuer_pk_key) do
    asset_type = AssetType.new(:ASSET_TYPE_CREDIT_ALPHANUM4)
    issuer = create_account_id(issuer_pk_key)

    code
    |> AssetCode4.new()
    |> AlphaNum4.new(issuer)
    |> Asset.new(asset_type)
  end

  def create_asset(:alpha_num12, code: code, issuer: issuer_pk_key) do
    asset_type = AssetType.new(:ASSET_TYPE_CREDIT_ALPHANUM12)
    issuer = create_account_id(issuer_pk_key)

    code
    |> AssetCode12.new()
    |> AlphaNum12.new(issuer)
    |> Asset.new(asset_type)
  end

  @spec payment_op_body(destination :: MuxedAccount.t(), asset :: Asset.t(), amount :: Int64.t()) ::
          OperationBody.t()
  def payment_op_body(destination, asset, amount) do
    destination
    |> Payment.new(asset, amount)
    |> OperationBody.new(OperationType.new(:PAYMENT))
  end

  @spec clawback_op_body(asset :: Asset.t(), from :: MuxedAccount.t(), amount :: Int64.t()) ::
          OperationBody.t()
  def clawback_op_body(asset, from, amount) do
    asset
    |> Clawback.new(from, amount)
    |> OperationBody.new(OperationType.new(:CLAWBACK))
  end

  @spec build_decorated_signatures(signatures :: list(binary())) :: DecoratedSignatures.t()
  def build_decorated_signatures(signatures) do
    signatures
    |> Enum.map(&build_signature/1)
    |> DecoratedSignatures.new()
  end

  @spec build_signature(secret_seed :: binary()) :: DecoratedSignatures.t()
  def build_signature(<<_hint::binary-size(52), hint::binary-size(4)>> = secret_seed) do
    signature = Signature.new(secret_seed)

    hint
    |> SignatureHint.new()
    |> DecoratedSignature.new(signature)
  end
end
