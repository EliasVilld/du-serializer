--Localize functions.
local concat = table.concat
local sFormat=string.format

--For internal iteration, functions slightly different from the ordinary serialize and only returns the counter variable
local function internalSerialize(v,tC,t)
    local check = type(v)
    if check=="table" then
        t[tC]='{'
        tC=tC+1
        local tempC=tC
        if #v==0 then
            for k,e in pairs(v) do
                t[tempC]=k
                t[tempC+1]='='
                tempC=tempC+2
                tempC=internalSerialize(e,tempC,t)
                t[tempC]=','
                tempC=tempC+1
            end
        else
            for k,e in pairs(v) do
                tempC=internalSerialize(e,tempC,t)
                t[tempC]=','
                tempC=tempC+1
            end
        end
        if tempC==tC then
            t[tempC]='}'
            return tempC+1
        else
            t[tempC-1]='}'
            return tempC
        end
    elseif check=="string" then
        t[tC]=sFormat("%q",v)
        return tC+1
    elseif check=="number" then
        t[tC]=tostring(v)
        return tC+1
    elseif check=="boolean" then
        t[tC]=v and "true"or"false"
        return tC+1
    end
    return tC
end

function serialize(v,es)
    local t={}
    local tC=1
    local check = type(v)
    
    if check=="table" then
        t[tC]='{'
        tC=tC+1
        local tempC=tC
        if #v==0 then
            for k,e in pairs(v) do
                t[tempC]=k
                t[tempC+1]='='
                tempC=tempC+2
                tempC=internalSerialize(e,tempC,t)
                t[tempC]=','
                tempC=tempC+1
            end
        else
            for k,e in pairs(v) do
                tempC=internalSerialize(e,tempC,t)
                t[tempC]=','
                tempC=tempC+1
            end
        end
        if tempC==tC then
            t[tempC]='}'
        else
            t[tempC-1]='}'
        end
    elseif check=="string" then
        t[tC]=sFormat("%q",v)
    elseif check=="number" then
        t[tC]=tostring(v)
    elseif check=="boolean" then
        t[tC]=v and "true"or"false"
    end
    
    local s=concat(t)
    if es then s = s:gsub(".", {['"'] = "&d;", ["'"] = "&s;"}) end
    return s
end

-- Deserialize a string to a table
function deserialize(s)
	-- Replace escape characters " and '
    s=s:gsub("[&dqs;]+", {["&d;"] = '"', ["&s;"] = "'"})
    
    local s="_tmp="..s
    f=load(s)
    if f then f() else return nil end
    return _tmp
end
