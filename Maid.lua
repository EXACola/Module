local Maid = {};
Maid.Cache = {};


function Maid.new()
    local latestCache = #Maid.Cache
    Maid.Cache[latestCache+1] = {_env={}}

    return setmetatable(Maid.Cache[latestCache+1],Maid)
end;

function Maid.__index(self,key)
    if (Maid[key]) then 
        return Maid[key];
    end;

    return self._env[key]
end;

function Maid:GiveOrder(thread,key)
    warn(thread)
    if (not thread) then 
        warn('Please assign me a job...');
    end;

    local latestTask = #self._env

    if (not key) then 
        table.insert(self._env,thread)
        return self._env[latestTask+1] 
    end;

    if (not key or type(key) ~= 'string') then 
        warn('Error: Maid.Order')
        return;
    end;

    self._env[key] = thread;


    return self._env[key];
end;

function Maid:GetOrders()
    return Maid.Cache;
end;

function Maid:ClearOrders()
    local myTask = self._env    

    for _,env in next, myTask do 
        code.cleaning(env);
    end;

    table.clear(myTask);
end;

function Maid.ClearCache()
    for _,cache in next, Maid.Cache do 
        if (cache and type(cache) == 'table' and cache._env) then 
            for __,env in next, cache._env do 
                code.cleaning(env);
            end;
        end;
    end;

    warn('Maid: ClearCache');
end;

return Maid;
