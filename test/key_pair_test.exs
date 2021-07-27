defmodule Stellar.KeyPair.CannedEd25519 do
  @moduledoc false

  @behaviour Stellar.KeyPair.Spec

  @public_key "GC3NRDSKRPYPRK3RBCCHOCG3HYJRXTTHCGI7TTF6KGSJH27GSEFWBB5M"
  @secret "SDOKIJIENHMYSALKQHHNDHOHPHBCSWRHAKJ6QHUCCABHF6ZREJG2BGJE"

  @impl true
  def random, do: {@public_key, @secret}

  @impl true
  def from_secret(_secret), do: {@public_key, @secret}
end

defmodule Stellar.KeyPairTest do
  use ExUnit.Case

  test "random/0" do
    {public_key, secret} = Stellar.KeyPair.random()
    56 = String.length(public_key)
    56 = String.length(secret)
  end

  describe "from_secret/1" do
    test "success" do
      {public_key, secret} = Stellar.KeyPair.random()
      {^public_key, ^secret} = Stellar.KeyPair.from_secret(secret)
    end

    test "bad secret" do
      assert_raise ArgumentError, "incorrect padding", fn ->
        Stellar.KeyPair.from_secret("SCPTLAI")
      end
    end
  end

  describe "custom ed25519 module" do
    setup do
      on_exit(fn -> Application.put_env(:stellar, :keypair_generator, Stellar.KeyPair.Default) end)

      %{
        public_key: "GC3NRDSKRPYPRK3RBCCHOCG3HYJRXTTHCGI7TTF6KGSJH27GSEFWBB5M",
        secret: "SDOKIJIENHMYSALKQHHNDHOHPHBCSWRHAKJ6QHUCCABHF6ZREJG2BGJE"
      }
    end

    test "random/0", %{public_key: public_key, secret: secret} do
      Application.put_env(:stellar, :keypair_generator, Stellar.KeyPair.CannedEd25519)
      {^public_key, ^secret} = Stellar.KeyPair.random()
    end

    test "from_secret/1", %{public_key: public_key, secret: secret} do
      Application.put_env(:stellar, :keypair_generator, Stellar.KeyPair.CannedEd25519)
      {^public_key, ^secret} = Stellar.KeyPair.from_secret(secret)
    end
  end
end
