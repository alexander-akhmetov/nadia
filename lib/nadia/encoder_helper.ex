defmodule Nadia.EncoderHelper do
  defmacro derive_jason_encoder(module) do
    quote do
      defimpl Jason.Encoder, for: unquote(module) do
        def encode(struct, options) do
          Map.from_struct(struct)
          |> Enum.reject(fn {_, v} -> is_nil(v) end)
          |> Map.new()
          |> Jason.Encoder.encode(options)
        end
      end
    end
  end
end
