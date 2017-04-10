# #Plugin template

# This is an pimatic plugin to connect to heat pumps based on the luxtronik 2.0 control.
# It uses the implementation from https://github.com/coolchip/luxtronik2

# ##The plugin code

module.exports = (env) ->

  # Require the  bluebird promise library
  Promise = env.require 'bluebird'

  # Require the [cassert library](https://github.com/rhoot/cassert).
  assert = env.require 'cassert'

  # Include you own depencies with nodes global require function:
  Luxtronik = require 'luxtronik2'
  commons = require('pimatic-plugin-commons')(env)

  # ###Luxtronik2Plugin class
  class Luxtronik2Plugin extends env.plugins.Plugin

    # ####init()
    #
    init: (app, @framework, config) =>
      @host = config.host
      @port = config.port
      @interval = config.interval
      @pump = new Luxtronik(@host, @port)


      # register devices
      deviceConfigDef = require("./device-config-schema.coffee")
      @framework.deviceManager.registerDeviceClass("Luxtronic2Data", {
        configDef: deviceConfigDef.Luxtronic2Data,
        createCallback: (config, lastState) =>
          return new Luxtronic2DataDevice config, @, lastState
      })

  class Luxtronic2DataDevice extends env.devices.Device
    attributes:
      temperatureSupply:
        description: "The measured temperature"
        type: "number"
        unit: '°C'

    temperatureSupply: 0.0


    constructor: (@config, @plugin, @service) ->
      @id = @config.id
      @base = commons.base @, @config.class unless @base?
      @name = @config.name
      @pump = @plugin.pump
      @interval = 1000 * @plugin.interval
      super()

      process.nextTick () =>
        @_requestUpdate()

      @on 'data', ((data) =>
        @temperature_supply = data.values.temperature_supply
        env.logger.info(@temperature_supply)
      )

    destroy: () ->
      @base.cancelUpdate()
      super()

    _requestUpdate: ->
      pump = @pump
      new Promise((resolve, reject) ->
        pump.read false, (data) ->
          if data.error
            reject data.error
          else
            resolve data
          return
        return
      ).then((data) =>
        @temperatureSupply = data.values.temperature_supply
        env.logger.info(@temperatureSupply)
        @emit "temperatureSupply", @temperatureSupply
      ).catch((error) =>
        env.logger.error(error)
      ).finally(() =>
        @base.scheduleUpdate @_requestUpdate, @interval
      )

    getTemperatureSupply: -> Promise.resolve @temperatureSupply

  # Create a instance of luxtronik2 plugin
  luxtronik2 = new Luxtronik2Plugin
  # and return it to the framework.
  return luxtronik2
