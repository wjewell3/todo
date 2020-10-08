defmodule Todo.Utils do
  require Logger

  def create_ets_table(table_name) do
    :ets.new(table_name, [
      :duplicate_bag,
      :public,
      :named_table,
      read_concurrency: true,
      write_concurrency: true
    ])
  end

  def string_downcase(val) do
    if is_binary(val) do
      String.downcase(val)
    else
      "nil"
    end
  end

  def ets_select(table) do
    :ets.select(table, [{:"$1", [], [:"$1"]}])
    |> Enum.map(fn {row} -> row end)
  end

  def ets_table_key_lookup(ets_table, key) do
    try do
      :ets.lookup(ets_table, string_downcase(key))
      |> Enum.map(fn {_k, v} -> v end)
    catch
      _, _ ->
        []
    end
  end

  def ets_select(ets_table, filter, filter_val) do
    try do
      :ets.select(ets_table, [{:"$1", [], [:"$1"]}])
      |> Enum.map(fn {row} -> row end)
      |> Enum.filter(fn f ->
        String.downcase(Map.get(f, String.to_atom(filter))) == String.downcase(filter_val)
      end)
    catch
      _, _ ->
        Logger.info(
          "Failed for ets select for filter -- #{filter} ets_table #{ets_table}, filter_val -- #{
            filter_val
          }"
        )

        []
    end
  end
end