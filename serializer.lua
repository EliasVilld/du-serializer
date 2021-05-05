-- Serialize a table to a string
function serialize(v,es)
    local t={}
    if type(v)=="table" then
        t[#t+1]='{'

        for k,e in pairs(v)do
            if#v==0 then t[#t+1]=k..'=' end
            t[#t+1]=serialize(e)
            t[#t+1]=','
        end

        if t[#t]==',' then t[#t]=nil end
        t[#t+1]='}'
    elseif type(v)=="number" then
        t[#t+1]=tostring(v)
    elseif type(v)=="string" then
        t[#t+1]=string.format("%q",v)
    elseif type(v)=="boolean" then
        t[#t+1]=v and "true"or"false"
    end

    t=table.concat(t)
	--Remove escape characters " and '
    if es then t = t:gsub(".", {['"'] = "&d;", ["'"] = "&s;"}) end

    return t
end

-- Deerialize a string to a table
function deserialize(s)
	-- Replace escape characters " and '
    s=s:gsub("[&dqs;]+", {["&d;"] = '"', ["&s;"] = "'"})
    
    local s="_tmp="..s
    f=load(s)
    if f then f() else return nil end
    return _tmp
end
