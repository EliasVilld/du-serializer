--Localize functions.
local concat = table.concat
local sFormat=string.format
--For internal iteration, functions slightly different from the ordinary serialize and only returns the counter variable
local function internalSerialize(v,tC,t)
  local check = type(v)
  local intSerial=internalSerialize
  if check=='table' then
    t[tC]='{'
    local tempC=tC+1
    if #v==0 then
      for k,e in pairs(v) do
        if type(k)~='number' then
          t[tempC]=k
          t[tempC+1]='='
          tempC=tempC+2
        else
          t[tempC]='['
          t[tempC+1]=k
          t[tempC+2]=']='
          tempC=tempC+3
        end
        tempC=intSerial(e,tempC,t)
        t[tempC]=','
        tempC=tempC+1
      end
    else
      for k,e in pairs(v) do
        tempC=intSerial(e,tempC,t)
        t[tempC]=','
        tempC=tempC+1
      end
    end
    if tempC==(tC+1) then
      t[tempC]='}'
      return tempC+1
    else
      t[tempC-1]='}'
      return tempC
    end
  elseif check=='string' then
    t[tC]=sFormat("%q",v)
    return tC+1
  elseif check=='number' then
    t[tC]=tostring(v)
    return tC+1
  else
    t[tC]=v and 'true' or 'false'
    return tC+1
  end
  return tC
end
function serialize(v)
    local t={}
    local tC=1
    local check = type(v)
    local intSerial=internalSerialize
    if check=='table' then
        t[tC]='{'
        tC=tC+1
        local tempC=tC
        if #v==0 then
            for k,e in pairs(v) do
              if type(k)~='number' then
                t[tempC]=k
                t[tempC+1]='='
                tempC=tempC+2
              else
                t[tempC]='['
                t[tempC+1]=k
                t[tempC+2]=']='
                tempC=tempC+3
              end
                tempC=intSerial(e,tempC,t)
                t[tempC]=','
                tempC=tempC+1
            end
        else
            for k,e in pairs(v) do
                tempC=intSerial(e,tempC,t)
                t[tempC]=','
                tempC=tempC+1
            end
        end
        if tempC==tC then
            t[tempC]='}'
        else
            t[tempC-1]='}'
        end
    elseif check=='string' then
        t[tC]=sFormat("%q",v)
    elseif check=='number' then
        t[tC]=tostring(v)
    else
        t[tC]=v and 'true' or 'false'
    end

    return concat(t)
end

-- Deserialize a string to a table
function deserialize(s)
    local f=loadstring('t='..s)
    f()
    return t
end
