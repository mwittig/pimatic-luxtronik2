module.exports = {
  title: "pimatic-luxtronik2 device config schemas"
  Luxtronic2Data: {
    title: "Luxtronic2 Data Device"
    description: "Provides access to heat pump data based on the luxtronik 2.0 control"
    type: "object"
    extensions: ["xLink", "xAttributeOptions"]
    properties:
      attributes:
        type: "array"
        default: ["temperatureOutside", "temperatureOutsideAvg", "temperatureHotWater", "temperatureHotWaterTarget", "heatpumpState", "lastError"]
        format: "table"
        items:
          type: "string"
  }
}