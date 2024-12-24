local p = {}
-- 计算轨道六根数的函数
local function calculateOrbitalElements(tle)
    local line2 = tle[2]

    -- 解析第二行
    local inclination = tonumber(line2:sub(9, 16)) * math.pi / 180
    local rightAscensionAscendingNode = tonumber(line2:sub(18, 25)) * math.pi / 180
    local eccentricity = tonumber("0." .. line2:sub(27, 32))
    local argumentPerigee = tonumber(line2:sub(35, 42)) * math.pi / 180
    local meanAnomaly = tonumber(line2:sub(44, 51)) * math.pi / 180
    local meanMotion = tonumber(line2:sub(53, 62))

    -- 根据地球引力常数和平均运动计算半长轴
    local muEarth = 3.986004418E+14 -- 地球引力常数 (m^3/s^2)
    local n = meanMotion * 2 * math.pi / 86400 -- 平均运动 (rad/s)
    local a = (muEarth / (n ^ 2)) ^ (1 / 3) -- 半长轴 (m)

    -- 使用牛顿-拉弗森法求解偏近点角 E
    local E = meanAnomaly -- 初始猜测值
    local tolerance = 1e-8
    local maxIterations = 100
    local iteration = 0

    repeat
        local f = E - eccentricity * math.sin(E) - meanAnomaly
        local df = 1 - eccentricity * math.cos(E)
        E = E - f / df
        iteration = iteration + 1
    until math.abs(f) < tolerance or iteration >= maxIterations

    -- 计算真近点角 φ
    local trueAnomaly = 2 * math.atan(math.sqrt((1 + eccentricity) / (1 - eccentricity)) * math.tan(E / 2))

    -- 返回轨道六根数作为数组
    return {
        a,                  -- 半长轴 (m)
        eccentricity,       -- 离心率
        inclination,        -- 轨道倾角 (rad)
        argumentPerigee,    -- 近心点辐角 (rad)
        rightAscensionAscendingNode, -- 升交点经度 (rad)
        trueAnomaly         -- 真近点角 (rad)
    }
end

function p.tleParser(frames)
    local args = frames.args
    local tle = args[1]
    local orbitalElements = calculateOrbitalElements(tle)
    return orbitalElements
end

return p