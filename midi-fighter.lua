-- MIDI Fighter Spectra tests.

local mf = nil

local function midi_event(data)
    print("Incoming")
    local msg = midi.to_msg(data)
    
    if msg.type == "note_on" then
        print("ON", msg.ch, msg.note, msg.vel)
        mf:note_on(36, 16, 3)
    elseif msg.type == "note_off" then
        print("OFF", msg.ch, msg.note)
        mf:note_off(36, 127, 3)
    end
    
    for k, _ in pairs(msg) do print(k) end
end

function init()
    mf = midi.connect(2)
    print(mf)
    mf.event = midi_event
    screen.clear()
end

local val = 0

function key(n, z)
    if z == 1 then
        print(">")
        mf:note_on(36, val, 3)
    else
        print("<")
        mf:note_off(36, 127, 3)
    end
end

function enc(n, d)
    val = math.min(math.max(val + d, 0), 127)
    print(val)
end
