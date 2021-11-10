defmodule StellarBase.StrKeyError do
  @moduledoc """
  Handle exceptions that may arise from the `StellarBase.StrKey` implementation.
  """
  @type t :: %__MODULE__{message: String.t()}

  defexception [:message]

  @spec exception(type :: atom()) :: no_return()
  def exception(:invalid_binary), do: %__MODULE__{message: "cannot encode nil data"}
  def exception(:invalid_data), do: %__MODULE__{message: "cannot decode nil data"}
  def exception(:invalid_checksum), do: %__MODULE__{message: "invalid checksum"}
  def exception(:unmatched_version_byte), do: %__MODULE__{message: "version byte does not match"}
  def exception(message), do: %__MODULE__{message: message}
end
