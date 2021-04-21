<!-- Introduction -->
# du-serializer
A Lua library to serialize table in string in Dual Universe to improve performances and reduce size to store data in databanks or for transmissions.

<!--List of methods and explanation -->
# Documentation
#### serialize(*table* t)
Serialize a table **t** and return a string.
*Tables and arrays are supported, not mixed table*

#### deserialize(*string* s)
Deserialize a serialized table as string **s** and return the table.


<!--Warnings concerning use -->
# Benchmark
Following graphs are the results of the benchmark, encoding and decoding a simple test table in [`bench.lua`](bench/bench.lua) multiple times.
Dkjson is a popular JSON encoding/decoding library in Lua, which is embedded by default in Dual Universe.
Pure Lua Json, is a compact pure-Lua alternative library for JSON encoding/decoding, can be found at [json.lua 0.1.2](https://github.com/rxi/json.lua), created by Rxi.

![The graph of decoding benchmark results](bench/decode.PNG)![The graph of encoding benchmark results](bench/encode.PNG)![The graph of data sizing benchmark results](bench/data_size.PNG)


<!-- How to use -->
# How to use

<!-- Explain how to use -->
# Examples
