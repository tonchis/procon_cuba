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
