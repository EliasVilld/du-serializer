<!-- Introduction -->
# du-serializer

[![Tests](https://github.com/EliasVilld/du-serializer/actions/workflows/test.yml/badge.svg?branch=main)](https://github.com/EliasVilld/du-serializer/actions/workflows/test.yml)

A Lua library to serialize table in string in Dual Universe to improve performances and reduce size to store data in databanks or for transmissions.

<!--List of methods and explanation -->
# Documentation
#### serialize(*table* t)
Serialize a table **t** and return a string.
*Tables and arrays are supported, not mixed table.* See [serializer_spec.lua](serializer_spec.lua) for supported and unsupported cases.

#### deserialize(*string* s)
Deserialize a serialized table as string **s** and return the table.


<!--Warnings concerning use -->
# Benchmark
Following graphs are the results of the benchmark, encoding and decoding a simple test table in [`bench.lua`](bench/bench.lua) multiple times.
Dkjson is a popular JSON encoding/decoding library in Lua, which is embedded by default in Dual Universe.
Pure Lua Json, is a compact pure-Lua alternative library for JSON encoding/decoding, can be found at [json.lua 0.1.2](https://github.com/rxi/json.lua), created by Rxi.

This benchmark has been done in Dual Universe, on a clean programming board.
*The missing data for the dkjson and pure lua json is due to the fact it trigger the CPU OVERLOAD error in the game.*

<img src="https://github.com/EliasVilld/du-serializer/blob/main/bench/Encoding%20Performances.png" width="600">
<img src="https://github.com/EliasVilld/du-serializer/blob/main/bench/Decoding%20Performances.png" width="600">
<img src="https://github.com/EliasVilld/du-serializer/blob/main/bench/Encoded%20Data%20Size.png" width="600">
*Benchmark updated the 09/25/2021.*

<!-- How to use -->
# How to use
To use this library in Dual Universe, you can simply copy the lua code and paste it in a Library slot. It can be used to compute transmissions for the [`du-socket`](https://github.com/EliasVilld/du-socket) library. See below an example :
```lua
local player = {
  id = 999,
  name = "Username",
  pos = { 1, 2, 3},
  org = "Org name",
  relation = 0
}

local s = serialize(player) -->  {relation=0,org="Org name",pos={1,2,3},id=999,name="Username"}
local t = deserialize(s)
print(t.name) --> Username

```
Keep in mind that for Lua-keyed tables, they are not ordered. However, ordinary arrays using integer indexes are ordered. 
(As seen in the above example, the pos data within that field will be ordered, but the position that the pos key takes will not.)

<!-- Explain how to use -->
# Credits
Thanks to Arialia for her collaboration from the game organization Silentium
