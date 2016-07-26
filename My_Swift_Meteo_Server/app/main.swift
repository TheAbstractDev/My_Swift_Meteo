//
//  main.swift
//
//  Copyright © 2015-2016 Daniel Leping (dileping). All rights reserved.
//

import Express

let app = express()
app.views.register(JsonView())

app.get("/") { request in
  let response = [
    "status": "ok"
  ]
  return Action.render(JsonView.name, context: response)
}

app.listen(4000).onSuccess { server in
  print("Server launched on port", server.port)
}

app.run()