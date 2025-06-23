package.path = package.path .. ";../src/luaprofile/?.lua"
package.cpath = package.cpath .. ";../src/luaprofile/?.so"

local profile = require "profile"

profile.start()

for i = 1, 1000000 do
    print(i)
end

local result = profile.stop()
print(result)