

_G.json = require("lib.json")

_G.log = require("log")

_G.db = require("db")

_G.typecheck = require("typecheck")

_G.objects = require("objects.exports")

_G.consts = require(".consts")


local localize = require("loc")
_G.loc = localize.localize
_G.interp = localize.newInterpolator

