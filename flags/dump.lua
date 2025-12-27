function Dump(tbl)
    io.write("{")
    for k, v in pairs(tbl) do
        io.write(k .. " = ")
        if type(v) == "table" then
            Dump(v)
        else
            io.write(tostring(v))
        end
        io.write(", ")
    end
    io.write("}")
end

return Dump