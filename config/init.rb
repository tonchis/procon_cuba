require "cuba"
require "cuba/render"
require "rack/protection"
require "securerandom"
require "mysql"
require "sequel"
require "shield"
require "logger"

DB = Sequel.connect("mysql://root@localhost/procon_development")
DB.loggers << Logger.new(STDOUT)

Cuba.settings[:session] = {key: "procon",
                           secret: "c086705ad2225ae4310241a10b07568di831d5eee2fd8090cd5947e0ae14500ed"}
