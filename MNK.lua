function get_sets()

	send_command('bind f9 gs c toggle TP set')
	send_command('bind f10 gs c toggle Idle set')

	
	function file_unload()
      
 
        send_command('unbind ^f9')
        send_command('unbind ^f10')
		send_command('unbind ^f11')
		send_command('unbind ^f12')
       
        send_command('unbind !f9')
        send_command('unbind !f10')
		send_command('unbind !f11')
        send_command('unbind !f12')
 
        send_command('unbind f9')
        send_command('unbind f10')
        send_command('unbind f11')
        send_command('unbind f12')
 
       
 
	end	
		
	--Idle Sets--	
	sets.Idle = {}
	
	sets.Idle.index = {'Standard', 'DT'}
	Idle_ind = 1			
	
	sets.Idle.Standard = { }
						  
	sets.Idle.DT = { }
	
	
	--TP Sets--
	sets.TP = {}

	sets.TP.index = {'Standard', 'Hybrid', 'DT'}
	TP_ind = 1
	
	sets.TP.Standard = { }
						
	
	sets.TP.Hybrid = { }
	

	sets.TP.DT = { }

	
	
		--Weaponskill Sets--
	sets.WS = {}
	
	sets.WS.VictorySmite = { }

	sets.WS.HowlingFist = { }

	sets.WS.RagingFist = { }
		
	sets.WS.ShijinSpiral = { }
	
	sets.WS.AsuranFists = { }
	
	sets.WS.TornadoKick = { }


		--Job Ability Sets--
	sets.JA = {}
	
	sets.JA.Chakra = { }
	
	sets.JA.Focus = { }
	
	sets.JA.Boost = { }
	
	sets.JA.Dodge = { }
	
	sets.JA.Impetus = {body="Bhikku Cyclas +1"}
	
	sets.JA.Mantra = {}
	
		--Fast Cast--
	
	sets.FC = {}
	
	sets.FC.precast = { }
	
	
	
	
	
	
	
	
	
end



function precast(spell)
	
	
	if spell.action_type == 'Magic' then
		equip(sets.FC.precast)
	end
	
	if spell.english == 'Victory Smite' then
		equip(sets.WS.VictorySmite)
	end
	if spell.english == 'Shijin Spiral' then
		equip(sets.WS.ShijinSpiral)
	end
	if spell.english == 'Tornado Kick' or spell.english == 'Dragon Kick' then
		equip(sets.WS.TornadoKick)
	end
	if spell.english == 'Howling Fist' then
		equip(sets.WS.HowlingFist)
	end 
	if spell.english == 'Raging Fists' then
		equip(sets.WS.RagingFist)
	end
	if spell.english == 'Asuran Fists' then
		equip(sets.WS.AsuranFists)
	end
	if spell.english == 'Focus' then	
		equip(sets.JA.Focus)
	end	
	if spell.english == 'Chakra' then	
		equip(sets.JA.Chakra)
	end
	if spell.english == 'Impetus' then	
		equip(sets.JA.Impetus)
	end
	if spell.english == 'Boost' then	
		equip(sets.JA.Boost)
	end	
	if spell.english == 'Dodge' then	
		equip(sets.JA.Dodge)
	end
	if buffactive["Impetus"] and spell.english == "Victory Smite"  then
      equip(
        set_combine(
          sets.WS[spell.english],
          sets.JA.Impetus)
		  )
	end
	
	
end
	


function aftercast(spell)
	if player.status == 'Engaged' then
		equip(sets.TP[sets.TP.index[TP_ind]])
	else
		equip(sets.Idle[sets.Idle.index[Idle_ind]])
	end
	if buffactive["Impetus"] then
        equip(sets.JA.Impetus)
      end
	
	if spell.action_type == 'Weaponskill' then
		add_to_chat(158,'TP Return: ['..tostring(player.tp)..']')
	end
end

function status_change(new,old)
	if new == 'Engaged' then
		equip(sets.TP[sets.TP.index[TP_ind]])
		if buffactive["Impetus"] then
        equip(sets.JA.Impetus)
		end
	else
		equip(sets.Idle[sets.Idle.index[Idle_ind]])
	end
end

function self_command(command)
	if command == 'toggle TP set' then
		TP_ind = TP_ind +1
		if TP_ind > #sets.TP.index then TP_ind = 1 end
		send_command('@input /echo <----- TP Set changed to '..sets.TP.index[TP_ind]..' ----->')
		equip(sets.TP[sets.TP.index[TP_ind]])
	elseif command == 'toggle Idle set' then
		Idle_ind = Idle_ind +1
		if Idle_ind > #sets.Idle.index then Idle_ind = 1 end
		send_command('@input /echo <----- Idle Set changed to '..sets.Idle.index[Idle_ind]..' ----->')
		equip(sets.Idle[sets.Idle.index[Idle_ind]])
	elseif command == 'equip TP set' then
		equip(sets.TP[sets.TP.index[TP_ind]])
	elseif command == 'equip Idle set' then
		equip(sets.Idle[sets.Idle.index[Idle_ind]])
	end
end
