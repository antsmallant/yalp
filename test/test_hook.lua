-- from https://www.zhihu.com/question/307064711/answer/3287762027

local function cc(i)
    if i <= 0 then
        return 0
    end
    return cc(i-1)
end

local function aa()
    local j = 0
    for i=1, 100 do
        cc(10)
    end
end

local lst_item = {}
local map_record = {}
debug.sethook(function(hook_type)
        local func_info = debug.getinfo(2, 'nSl')
        local key = func_info.short_src ..":".. func_info.linedefined

        local now = os.clock()
        if hook_type == "call" then
            table.insert(lst_item,{
                call_time = now,
                key = key,
            })
        elseif hook_type == "return" then
            local item = table.remove(lst_item)
            if not item then return end

            local record = map_record[key]
            if record then
                record.call_count = record.call_count + 1
                record.total_time = record.total_time + (now - item.call_time)
            else
                map_record[key] = {
                    call_count = 1,
                    total_time = now - item.call_time,
                    name = func_info.name,
                    line = func_info.linedefined,
                    source = func_info.short_src,
                }
            end
        elseif hook_type == "tail call" then
            print("tail call")
        end
    end, 'cr', 0)

local start_time = os.clock()
aa()

local total_time = 0
for k,v in pairs(map_record) do
    total_time = total_time + v.total_time
    local use_time = string.format("%4.3f", v.total_time)
    print(string.format("%7s  %10d  %20s  %s", use_time, v.call_count, v.name, k))
end
print("-----------------------")
print("total_time: ", total_time)
print("real use time:", os.clock() - start_time)