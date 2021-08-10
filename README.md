# Elixir Stellar Base

### **⚠️ Warning! This library is under active development**. Do not use it in production environments.

`stellar_base` is an **Elixir library** that provides a complete set of functions to read, write, hash, and sign XDR primitive constructs used in [stellar-core](https://github.com/stellar/stellar-core).

This library is aimed at developers building Elixir applications on top of the Stellar network. Transactions constructed by this library may be submitted to any Horizon instance for processing onto the ledger, using any Stellar SDK client. The recommended client for Elixir programmers is [stellar_sdk][sdk].

## stellar_base vs stellar_sdk
* `stellar_sdk` is a client library for interfacing with **Horizon** server REST endpoints to retrieve ledger information and submit transactions built with `stellar_base`.
* `stellar_base` enables the construction, signing, and encoding of Stellar transactions.
* Use the `stellar_base` library if are planning to build on top of it.

## Installation
[Available in Hex][hex], add `stellar_base` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:stellar_base, "~> 0.0.1"}
  ]
end
```

## Development
* Install an `elixir >= 1.10` version.
* Compile dependencies: `mix deps.get`.
* Run tests: `mix test`.

## Code of conduct
We welcome everyone to contribute. Make sure you have read the [CODE_OF_CONDUCT][coc] before.

## Contributing
For information on how to contribute, please refer to our [CONTRIBUTING][contributing] guide.

## Changelog
Features and bug fixes are listed in the [CHANGELOG][changelog] file.

## License
This library is licensed under an MIT license. See [LICENSE][license] for details.

## Acknowledgements
Made with 💙 by [kommitters Open Source](https://kommit.co)

[license]: https://github.com/kommitters/stellar_base/blob/master/LICENSE.md
[coc]: https://github.com/kommitters/stellar_base/blob/master/CODE_OF_CONDUCT.md
[changelog]: https://github.com/kommitters/stellar_base/blob/master/CHANGELOG.md
[contributing]:https://github.com/kommitters/stellar_base/blob/master/CONTRIBUTING.md
[base]: https://github.com/kommitters/stellar_base
[sdk]: https://github.com/kommitters/stellar_sdk
[hex]: https://hex.pm/packages/stellar_base
