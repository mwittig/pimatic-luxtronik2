module.exports = {
  title: "pimatic-luxtronik2 device config schemas"
  Luxtronic2Data: {
    title: "Luxtronic2 Data Device"
    description: "Provides access to heat pump data based on the luxtronik 2.0 control"
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