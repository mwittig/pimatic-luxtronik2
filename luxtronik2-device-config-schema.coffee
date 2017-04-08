module.exports = {
  title: "pimatic-websolarlog device config schemas"
  Luxtronic2Data: {
    title: "Fronius GetPowerFlowRealtimeData Device "
    description: "Provides access to data of a Fronius Inverter supporting Solar API 1.1"
    type: "object"
    extensions: ["xLink", "xAttributeOptions"]
    properties:
      attributes:
        type: "array"
        default: ["mode", "powerGrid", "powerLoad", "powerAkku", "powerGenerate", "energyDay", "energyYear", "energyTotal"]
        format: "table"
        items:
          type: "string"
      host:
        description: "IP address or hostname of the device providing the Solar REST Service"
        type: "string"
      port:
        description: "Port of the device providing the Solar REST Service"
        type: "number"
        default: 80
      username:
        description: "Username used to obtain access. Omitted, if authentication has been disabled."
        type: "string"
        required: false
      password:
        description: "Password used to obtain access. Omitted, if authentication has been disabled."
        type: "string"
        required: false
      interval:
        description: "Polling interval in seconds, value range [10-86400]"
        type: "number"
        default: 60
      threshold:
        description: "Threshold for PowerSaveMode of Inverter Device"
        type: "number"
        default: 0
  }
}