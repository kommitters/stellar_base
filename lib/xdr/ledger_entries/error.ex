defmodule StellarBase.XDR.AssetCode4Error do
  @moduledoc """
  Module to handle exceptions that may arise from the `StellarBase.XDR.AssetCode4` implementation.
  """

  @type t :: %__MODULE__{message: String.t()}

  defexception [:message]

  @spec exception(type :: atom()) :: no_return()
  def exception(:invalid_length),
    do: %__MODULE__{
      message:
        "Invalid code length for AssetCode4. A string between 1 and 4 characters is expected."
    }
end

defmodule StellarBase.XDR.AssetCode12Error do
  @moduledoc """
  Module to handle exceptions that may arise from the `StellarBase.XDR.AssetCode12` implementation.
  """
  @type t :: %__MODULE__{message: String.t()}

  defexception [:message]

  @spec exception(type :: atom()) :: no_return()
  def exception(:invalid_length),
    do: %__MODULE__{
      message:
        "Invalid code length for AssetCode12. A string between 5 and 12 characters is expected."
    }
end
