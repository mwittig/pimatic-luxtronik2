module.exports = {
  title: "pimatic-websolarlog device config schemas"
  Luxtronic2Data: {
    title: "Fronius GetPowerFlowRealtimeData Device "
    description: "Provides access to data of a Fronius Inverter supporting Solar API 1.1"
    type: "object"
    extensions: ["xLink", "xAttributeOptions"]
    properties:
      temperatureSupply:
        description: "The measured temperature"
        type: "number"
        unit: '°C'
        required: false
  }
}