# #Plugin template

# This is an plugin template and mini tutorial for creating pimatic plugins. It will explain the 
# basics of how the plugin system works and how a plugin should look like.

# ##The plugin code

# Your plugin must export a single function, that takes one argument and returns a instance of
# your plugin class. The parameter is an envirement object containing all pimatic related functions
# and classes. See the [startup.coffee](http://sweetpi.de/pimatic/docs/startup.html) for details.
module.exports = (env) ->

  # ###require modules included in pimatic
  # To require modules that are included in pimatic use `env.require`. For available packages take
  # a look at the dependencies section in pimatics package.json

  # Require the  bluebird promise library
  Promise = env.require 'bluebird'

  # Require the [cassert library](https://github.com/rhoot/cassert).
  assert = env.require 'cassert'

  # Include you own depencies with nodes global require function:
  Luxtronik = require 'luxtronik2'
  Promise.promisifyAll(Luxtronik.prototype)
  commons = require('pimatic-plugin-commons')(env)

  # ###Luxtronik2Plugin class
  # Create a class that extends the Plugin class and implements the following functions:
  class Luxtronik2Plugin extends env.plugins.Plugin

    # ####init()
    # The `init` function is called by the framework to ask your plugin to initialise.
    #
    # #####params:
    #  * `app` is the [express] instance the framework is using.
    #  * `framework` the framework itself
    #  * `config` the properties the user specified as config for your plugin in the `plugins`
    #     section of the config.json file
    #
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

      @pump.readAsync(false).then((data) =>
        @temperatureSupply = data.values.temperature_supply
        env.logger.info(@temperatureSupply)
        @emit "temperatureSupply", @temperatureSupply
      ).catch((data) =>
        @temperatureSupply = data.values.temperature_supply
        env.logger.info(@temperatureSupply)
        @emit "temperatureSupply", @temperatureSupply
      ).finally(() =>
        @base.scheduleUpdate @_requestUpdate, @interval
      )

    getTemperatureSupply: -> Promise.resolve @temperatureSupply

  # ###Finally
  # Create a instance of my plugin
  luxtronik2 = new Luxtronik2Plugin
  # and return it to the framework.
  return luxtronik2
