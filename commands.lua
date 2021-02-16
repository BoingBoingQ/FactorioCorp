/c
apflu="apflu"
bbq="BoingBoingQ"
weak="mhz123"

home={0.5,0.5}
kulp={30.5,65.5}
oild={-203.5,141.5}
pipe={44.5,65.5}
refi={-90.5,64.5}
delve={251.5,1795.5}
vosi={-345.5,899.5}
crox={-13.5,880.5}
train={-39.5,177.5}
branch={191.5,1435.5}

moon={43.5,-59.5}

last_position={}

function tp(target)
    last_position[game.player.name]=game.player.position
    game.player.teleport(target)
end

function tpto(target)
    last_position[game.player.name]=game.player.position
    local position=game.players[target].position
    game.player.teleport({position.x+1, position.y+1})
end

function back()
    if(last_position[game.player.name] == nil) then
        tp(home)
    else
        tp(last_position[game.player.name])
    end
end

function tp_space()
    game.player.teleport({68,-7},"Nauvis Orbit")
end

function give(item, amount)
    game.player.insert{name=item, count=amount}
end

function evo()
    game.print("虫子进化系数: "..game.forces["enemy"].evolution_factor)
end

function getpos()
    local position = game.player.position
    game.print(game.player.name .. "位于[gps=" .. position.x .. "," .. position.y .. "," .. game.player.surface.name .. "]")
end

function findcorpse()
    local found_corpses = game.player.surface.find_entities_filtered{type="character-corpse"}
    for _,corpse in pairs(found_corpses) do
        local player = game.get_player(corpse.character_corpse_player_index)
        local name = player and player.name or "????"
        game.print(name .. " --> [gps=" .. corpse.position.x .. "," .. corpse.position.y .. "]")
    end
end

function speedup(factor)
    for _,player in pairs(game.players) do
        player.force.manual_crafting_speed_modifier=factor
        game.print("将" .. game.player.name .. "的手搓制造速度设置成了" .. factor .. "倍！")
    end
end

function tree()
    math.randomseed(game.tick)
    local radius = 10
    local interval = 16
    local type = "tree-0"
    for y=-radius,radius do
	    for x=-radius,radius do
		    thisX = game.player.position.x+x*2+math.random(1,interval)
		    thisY = game.player.position.y+y*2+math.random(1,interval)
		    thistiletype = game.player.surface.get_tile(thisX, thisY).name
		    if thistiletype ~= "water" and thistiletype ~= "deepwater" then
			    game.surfaces.nauvis.create_entity({ name=type .. math.random(1,4), amount=1, position={thisX,thisY}})
		    end
	    end
    end
end

game.print("初始化完成！")