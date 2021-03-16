defmodule DayToDate do
  @months ~w[January February March April May June July August September October November December]

  @doc """
  Examples (these are executable doctests):

  ```elixir
  iex> DayToDate.get_date(13, false)
  "January, 13"

  iex> DayToDate.get_date(13, true)
  "January, 13"

  iex> DayToDate.get_date(41, false)
  "February, 10"

  iex> DayToDate.get_date(60, true)
  "February, 29"

  iex> DayToDate.get_date(60, false)
  "March, 1"

  iex> DayToDate.get_date(365, false)
  "December, 31"

  iex> DayToDate.get_date(366, true)
  "December, 31"
  ```
  """
  def get_date(day, leap_year?) do
    Enum.reduce_while(@months, day, fn month, remainder ->
      length = length(month, leap_year?)

      if remainder <= length do
        {:halt, "#{month}, #{remainder}"}
      else
        {:cont, remainder - length}
      end
    end)
  end

  defp length("February", false), do: 28
  defp length("February", true), do: 29
  defp length(month, _) when month in ~w[April June September November], do: 30
  defp length(_, _), do: 31
end
