# #my-plugin configuration options
# Declare your config option for your plugin here. 
module.exports = {
  title: "luxtronik2 plugin config options"
  type: "object"
  properties:
    host:
      description: "IP address or hostname of the luxtronik2 Service"
      type: "string"
      required: yes
    port:
      description: "Port of the luxtronik2 Service"
      type: "number"
      default: 8888
      required: yes
    interval:
      description: "Polling interval for switch state in seconds"
      type: "number"
      default: 60
}