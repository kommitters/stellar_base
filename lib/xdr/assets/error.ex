defmodule Stellar.XDR.AssetCode4Error do
  @moduledoc """
  Module to handle exceptions that may arise from the `Stellar.XDR.AssetCode4` implementation.
  """

  @type t :: %__MODULE__{message: String.t()}

  defexception [:message]

  @spec exception(type :: atom()) :: t()
  def exception(:invalid_length),
    do: %__MODULE__{
      message:
        "Invalid code lenght for AssetCode4. A string between 1 and 4 characters is expected."
    }
end

defmodule Stellar.XDR.AssetCode12Error do
  @moduledoc """
  Module to handle exceptions that may arise from the `Stellar.XDR.AssetCode12` implementation.
  """
  @type t :: %__MODULE__{message: String.t()}

  defexception [:message]

  @spec exception(type :: atom()) :: t()
  def exception(:invalid_length),
    do: %__MODULE__{
      message:
        "Invalid code lenght for AssetCode12. A string between 5 and 12 characters is expected."
    }
end
