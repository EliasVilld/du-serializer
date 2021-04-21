-- Functions and test table used to benchmark parsing methods.

-- Benchmark function created by Infernum
local units = {
    ['seconds'] = 1,
    ['milliseconds'] = 1000,
    ['microseconds'] = 1000000,
    ['nanoseconds'] = 1000000000
}

function benchmark(unit, decPlaces, n, f, ...)
    local elapsed = 0
    local multiplier = units[unit]
    for i = 1, n do
        local now = system.getTime()
        f(...)
        elapsed = elapsed + (system.getTime() - now)
    end
    system.print(string.format('Benchmark : %d calls | %.'.. decPlaces ..'f %s elapsed | %.'.. decPlaces ..'f %s average execution time.', n, elapsed * multiplier, unit, (elapsed / n) * multiplier, unit))
end

-- Test table
local data = {
  firstName= "John",
  lastName= "Smith",
  isAlive= true,
  age= 25,
  address= {
    streetAddress= "21 2nd Street",
    city= "New York",
    state= "NY",
    postalCode= "10021-3100"
  },
  phoneNumbers= {
    {
      type= "home",
      number= "212 555-1234"
    },
    {
      type= "office",
      number= "646 555-4567"
    }
  },
  children= {}
}
