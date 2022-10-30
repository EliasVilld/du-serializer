#!/usr/bin/env lua
--- Tests for serializer.

local luaunit = require("luaunit")
require("serializer")

--- Utility function to serialize input, deserialize the result, and compare input to result.
-- @param input The array, table, or other input to serialize.
-- @tparam boolean testNotIs True (default) to verify that the deserialized data is not the same reference as the
--   input. Set to false for primitive types.
-- @treturn string The serialized string, in case tests on the intermediate state are required.
local function verifySerializeDeserialize(input, testNotIs)
  local serialized = serialize(input)
  local output = deserialize(serialized)
  if testNotIs == nil or testNotIs then
    luaunit.assertNotIs(output, input)
  end
  luaunit.assertEquals(output, input)
  return serialized
end

--- Test serializing basic types by themselves.
TestSimpleValue = {}
function TestSimpleValue.testNil()
  luaunit.skip("Not supported: returns false")
  local input = nil
  verifySerializeDeserialize(input, false)
end
function TestSimpleValue.testBooleanFalse()
  local input = false
  verifySerializeDeserialize(input, false)
end
function TestSimpleValue.testBooleanTrue()
  local input = true
  verifySerializeDeserialize(input, false)
end
function TestSimpleValue.testNumberInteger()
  local input = 1
  verifySerializeDeserialize(input, false)
end
function TestSimpleValue.testNumberFloat()
  local input = 1.2
  verifySerializeDeserialize(input, false)
end
function TestSimpleValue.testStringBasic()
  local input = "string"
  verifySerializeDeserialize(input, false)
end
function TestSimpleValue.testStringSingleQuote()
  local input = "string with a ' in it"
  verifySerializeDeserialize(input, false)
end
function TestSimpleValue.testStringDoubleQuote()
  local input = 'string with a " in it'
  verifySerializeDeserialize(input, false)
end
function TestSimpleValue.testStringDoubleBrackets()
  local input = "string with [[ and ]]"
  verifySerializeDeserialize(input, false)
end
function TestSimpleValue.testStringAllGroupingSymbols()
  local input = "all the symbols: \" ' [[ ]]"
  verifySerializeDeserialize(input, false)
end
function TestSimpleValue.testTableEmpty()
  local input = {}
  verifySerializeDeserialize(input, false)
end

--- Test serializing arrays.
TestArray = {}
function TestArray.testBoolean()
  local input = {false, true}
  verifySerializeDeserialize(input)
end
function TestArray.testNumberInteger()
  local input = {1, 2}
  verifySerializeDeserialize(input)
end
function TestArray.testNumberFloat()
  local input = {1.2, 2.3}
  verifySerializeDeserialize(input)
end
function TestArray.testString()
  local input = {"string1", "string2"}
  verifySerializeDeserialize(input)
end
function TestArray.testStringSymbols()
  local input = {"'", '"', "[[", "]]"}
  verifySerializeDeserialize(input)
end
function TestArray.testArray()
  -- second value chosen to hit special handling in recursive call
  local input = {{"array1"}, {}}
  verifySerializeDeserialize(input)
end
function TestArray.testTable()
  -- second value chosen to hit special handling in recursive call
  local input = {{key1 = "table1"}, {[2] = "table2"}}
  verifySerializeDeserialize(input)
end

--- Test serializing tables.
TestTable = {}
function TestTable.testBooleanKey()
  local input = {
    [false] = 1
  }
  verifySerializeDeserialize(input)
end
function TestTable.testBooleanValue()
  local input = {bool = true}
  verifySerializeDeserialize(input)
end
function TestTable.testNumberInteger()
  local input = {[2] = 3}
  verifySerializeDeserialize(input)
end
function TestTable.testNumberFloat()
  local input = {[2.3] = 3.4}
  verifySerializeDeserialize(input)
end
function TestTable.testString()
  local input = {key = "value"}
  verifySerializeDeserialize(input)
end
function TestTable.testStringSpaces()
  local input = {["key spaces"] = "value spaces"}
  verifySerializeDeserialize(input)
end
function TestTable.testStringSymbols()
  local input = {["\"'[[]]"] = "\" ' [[ ]]"}
  verifySerializeDeserialize(input)
end
function TestTable.testArrayKey()
  luaunit.skip("not supported: array as key")
  local input = {[{"array 1"}] = "value"}
  verifySerializeDeserialize(input)
end
function TestTable.testArrayValue()
  local input = {array = {"array 2"}}
  verifySerializeDeserialize(input)
end
function TestTable.testTableKey()
  luaunit.skip("not supported: table as key")
  local input = {[{key = "value"}] = "value"}
  verifySerializeDeserialize(input)
end
function TestTable.testTableValue()
  local input = {table = {key = "value"}}
  verifySerializeDeserialize(input)
end

--- Test serializing mixed tables.
TestMixedTable = {}
function TestTable.testMixedTable()
  luaunit.skip("not supported: mixed tables")
  local input = {2, 3, [5] = 7}
  verifySerializeDeserialize(input)
end

os.exit(luaunit.LuaUnit.run())
