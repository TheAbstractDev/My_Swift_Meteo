//
//  main.swift
//
//  Copyright © 2015-2016 Daniel Leping (dileping). All rights reserved.
//

import Express
import SwiftyBeaver
import SwiftyJSON

let app = express()
app.views.register(JsonView())

let log = SwiftyBeaver.self
let console = ConsoleDestination()
console.detailOutput = false
console.dateFormat = "HH:mm:ss"
log.removeAllDestinations()
log.addDestination(console)

var weatherManager = WeatherManager(apiKey: "650e2a6cd7d34c84905105743162507")

app.get("/weather") { request in
  var response = Dictionary<String, String>()
  var semaphore = dispatch_semaphore_create(0)
  weatherManager.weatherData((request.query["city"]?.first)!) { (data) in
    dispatch_semaphore_signal(semaphore)
    response = data
  }
  dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
  return Action.render(JsonView.name, context: response)
}

app.listen(4000).onSuccess { server in
  log.verbose("Server launched on port \(server.port)")
}

app.run()