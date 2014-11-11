-- Copyright (C) 2014 Andreas Guth
--
-- This file is MIT/X11 licensed.
--
local st = require "util.stanza";

local _M = {};

function _M.new(to, from, message, log_attrs, tags)
    local stanza = stanza.message({ to = to, from = from, type = "normal", ["xml:lang"] = "en" })

    local log = { xmlns = "urn:xmpp:eventlog"}

    if log_attrs then
        for k, v in pairs(log_attrs) do
            log.attr[k] = v
        end
    end

    local log_element = stanza:tag("log", log):tag("message"):text(message):up()

    if tags then
        for _, tag in ipairs(tags) do
            log_element:tag("tag", tag):up()
        end
    end

    return stanza
end

function _M.new_log(message, log_attrs, tags)
    local log = stanza.stanza("log", { xmlns = "urn:xmpp:eventlog"})

    if log_attrs then
        for k, v in pairs(log_attrs) do
            log.attr[k] = v
        end
    end

    local log_element = log:tag("message"):text(message):up()

    if tags then
        for _, tag in ipairs(tags) do
            log_element:tag("tag", tag):up()
        end
    end

    return log_element
end

function _M.new_from_logs(to, from, logs)
    local stanza = stanza.message({ to = to, from = from, type = "normal", ["xml:lang"] = "en" })

    if logs then
        for _, log in ipairs(logs) do
            stanza:add_direct_child(log)
        end
    end

    return stanza
end

return _M;
