module.exports = {
  title: "pimatic-websolarlog device config schemas"
  Luxtronic2Data: {
    title: "Fronius GetPowerFlowRealtimeData Device "
    description: "Provides access to data of a Fronius Inverter supporting Solar API 1.1"
    type: "object"
    extensions: ["xLink", "xAttributeOptions"]
    properties:
      temperatureOutside:
        description: "The current outside temperature"
        type: "number"
        unit: '°C'
        required: false
      temperatureOutsideAvg:
        description: "The average outside temperature"
        type: "number"
        unit: '°C'
        required: false
      temperatureHotWater:
        description: "The current water temperature"
        type: "number"
        unit: '°C'
        required: false
      temperatureHotWaterTarget:
        description: "The target water temperature"
        type: "number"
        unit: '°C'
        required: false
      heatpumpState:
        description: "The current heat pump state"
        type: "string"
        required: false
      lastError:
        description: "The last error"
        type: "string"
        required: false
  }
}