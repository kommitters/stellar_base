defmodule Stellar.XDR.ThresholdsError do
  @moduledoc """
  Module to handle exceptions that may arise from the `Stellar.XDR.Thresholds` implementation.
  """
  @type t :: %__MODULE__{message: String.t()}

  defexception [:message]

  @spec exception(type :: atom()) :: no_return()
  def exception(:invalid_thresholds_specification),
    do: %__MODULE__{
      message:
        "Invalid thresholds specification. Thresholds must be provided as a keyword list -> master_weight: master_weight, low: low, med: med, high: high"
    }
end
