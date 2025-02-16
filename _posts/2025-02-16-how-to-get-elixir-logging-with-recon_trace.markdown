---
layout: post
title: How to get Elixir logging with recon_trace
category: posts
---

Previously, in [Using recon_trace with Elixir](/posts/using-recon_trace-with-elixir/), I had laid out a foundation
for using `:recon_trace` specifically with Elixir.

Since then, I decided to spend some time and "fix" the logging so I wouldn't
have to eyeball-decipher Erlang-flavored dumps.

## The problem

Imagine a very simple `Pet` module

```elixir
defmodule Pet do
  defstruct [:name, :age, :type]

  def just_cats(pets) do
    pets
    |> Enum.filter(&(&1.type == "cat"))
  end
end
```

Set up your `:recon_trace`

```elixir
[
  {Pet, :just_cats, :return_trace}
]
|> :recon_trace.calls({100, 1000}, scope: :local)
```

and trigger it

```elixir
# parenthesis-wrap and :ok return to simplify iex output...
(
  [
    %Pet{name: "Mittens", age: 4, type: "cat"},
    %Pet{name: "Oreo", age: 2, type: "cat"},
    %Pet{name: "Rocky", age: 5, type: "dog"}
  ]
  |> Pet.just_cats()
  :ok
)
```

here's a sample output

```text
15:20:49.473527 <0.261.0> 'Elixir.Pet':just_cats([#{name => <<"Mittens">>,type => <<"cat">>,'__struct__' => 'Elixir.Pet',
   age => 4},
 #{name => <<"Oreo">>,type => <<"cat">>,'__struct__' => 'Elixir.Pet',age => 2},
 #{name => <<"Rocky">>,type => <<"dog">>,'__struct__' => 'Elixir.Pet',
   age => 5}])
:ok

15:20:49.473865 <0.261.0> 'Elixir.Pet':just_cats/1 --> [#{name => <<"Mittens">>,type => <<"cat">>,'__struct__' => 'Elixir.Pet',
   age => 4},
 #{name => <<"Oreo">>,type => <<"cat">>,'__struct__' => 'Elixir.Pet',
   age => 2}]
```

This is workable ... but messy-looking. 🤔

## The solution

Let's write a formatter function

```elixir
require Logger
formatter = fn trace_payload ->
  [:trace, _pid | rest] = trace_payload |> Tuple.to_list()
  rest
  |> inspect()
  |> Logger.debug()
  "~n"
end
```

(It took me a while to get a formatter that I was happy with, and I'll dig deeper in the next section.)

Hook up your formatter during the `:recon_trace` setup

```elixir
[
  {Pet, :just_cats, :return_trace}
]
|> :recon_trace.calls({100, 1000}, scope: :local, formatter: formatter)
```

Trigger it (same as above). Here's the output now

```text
15:35:04.920 [debug] [:call, {Pet, :just_cats, [[%Pet{name: "Mittens", age: 4, type: "cat"}, %Pet{name: "Oreo", age: 2, type: "cat"}, %Pet{name: "Rocky", age: 5, type: "dog"}]]}]
:ok

15:35:04.920 [debug] [:return_from, {Pet, :just_cats, 1}, [%Pet{name: "Mittens", age: 4, type: "cat"}, %Pet{name: "Oreo", age: 2, type: "cat"}]]
```

The more structs and strings you have, the more you will benefit for Elixir-aware `inspect()`.

## Discussion

Digging into `recon`'s code, the [default formatter](https://github.com/ferd/recon/blob/master/src/recon_trace.erl#L516-L604) is _quite something_

[![code for default formatter](/assets/recon-trace-formatter/default-formatter.jpg)](/assets/recon-trace-formatter/default-formatter.jpg)

It stands at 80 lines, without counting its helpers. Long-story short:
- yes: this code attempts to make sense of the `TraceMsg`, and extract/format them into something useful
- but: personally, I haven't needed to untangle these details, so I'm fine dumping something a bit more raw
- you might get different number of items in the `TraceMsg` tuple, which is what `extract_info` focuses on -- but, again, I'm fine with dumping it raw

```erlang
extract_info(TraceMsg) ->
    case tuple_to_list(TraceMsg) of
        [trace_ts, Pid, Type | Info] ->
            {TraceInfo, [Timestamp]} = lists:split(length(Info)-1, Info),
            {Type, Pid, to_hms(Timestamp), TraceInfo};
        [trace, Pid, Type | TraceInfo] ->
            {Type, Pid, to_hms(os:timestamp()), TraceInfo}
    end.
```

Revisiting my formatter

```elixir
require Logger
formatter = fn trace_payload ->
  [:trace, _pid | rest] = trace_payload |> Tuple.to_list()
  rest
  |> inspect()
  |> Logger.debug()
  "~n"
end
```

- `Tuple.to_list()`
- keep everything after the `pid`, whatever it is
  - I wasn't interested in the `pid`, but you might be
- lean on `inspect()`
- send to `Logger`
- return "~n" to satisfy `:recon_trace`

## Overtime

Now that you are fully in charge of _HOW_ things are logged, you could _ALSO_ be in charge of _WHAT_ gets logged.

If you feel like pulling things apart and adding conditionals and filters, you
can _absolutely_ do that.

But keep in mind that you're paying-as-you-go, possibly on a production system. If
you are going to do something costly, you might end up hurting yourself. So, PLEASE use responsibly.

There are, after all, many ways to set more conservative filters during
the `:recon_trace` initialization. Refer to the [documentation](https://hexdocs.pm/recon/recon_trace.html#calls/3) as needed.
