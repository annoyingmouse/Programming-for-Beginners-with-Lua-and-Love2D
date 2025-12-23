function dump(tbl)
    io.write("{")
    for k, v in pairs(tbl) do
        io.write(k .. " = ")
        if type(v) == "table" then
            dump(v)
        else
            io.write(tostring(v))
        end
        io.write(", ")
    end
    io.write("}")
end

return dump