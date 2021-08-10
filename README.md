# Elixir Stellar Base
`stellar_base` is an elixir library that provides a complete set of low-level operations to read, write, hash, and sign XDR primitive constructs used in [stellar-core](https://github.com/stellar/stellar-core).

⚠️ Warning!
---
This library is under **active development**. Do not use it in production environments.

## stellar_base vs stellar_sdk
`stellar_sdk` is a high-level library that serves as an API for Horizon. `stellar_base` is a lower-level library for creating Stellar primitive constructs via XDR wrappers.

**Most people will want** [stellar_sdk][sdk] instead of [stellar_base][base]. Use the `stellar_base` library only if you are planning to build on top of it.

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
