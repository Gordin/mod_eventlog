-- Copyright (C) 2014 Andreas Guth
--
-- This file is MIT/X11 licensed.
--
local st = require "util.stanza";

local _M = {};

function _M.new(to, from, message, session_id, timestamp, log_attrs, tags)
    local stanza = stanza.message({ to = to, type = "normal", ["xml:lang"] = "en" })

    local log = { xmlns = "urn:xmpp:eventlog", id = session_id }

    if log_attrs then
        for k, v in pairs(log_attrs) do
            log[k] = v
        end
    end

    local log_element = stanza:tag("log", log):tag("message"):text(message):up()

    if tags then
        for tag in tags do
            log_element:tag("tag", tag)
        end
    end

    return stanza
end

return _M;
