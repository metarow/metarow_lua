# MetaRow

> Play with your data. Have fun with JSON.

## How It Works

MetaRow is an attempt to store business logic in a plain SQL database.
An application can use the table `_MetaRow` to save JSON strings.
These strings describes a database **model**,
application **views** and **controller** actions (MVC pattern).
In other words, the JSON strings defines a meta level for SQL databases.

The following keywords are formed this meta level.

<dl>
  <dt>fun</dt>
  <dd>
    Calls a code block when interpreting the JSON string.
  </dd>
  <dt>val</dt>
  <dd>Returns a simple values.</dd>
  <dt>calc</dt>
  <dd>Performs calculations in RPN notation.</dd>
</dl>

```json
[
  {
    "fun" : {
      "name" : "createRect",
      "params" : {
        "x" : { "val" : 0 },
        "y" : { "val" : 0 },
        "anchorX" : { "val" : 0 },
        "anchorY" : { "val" : 0 },
        "width" :  { "fun" : { "name":"screenWidth" }},
        "height" : { "calc" : [ "screenHeight()", "tabBarHeight()", "sub()" ] },
        "fillColor" : { "val" : [0.6] }
      }
    }
  },
  {
    "fun" : {
      "name" : "createRect",
      "params" : {
        "x" : { "calc" : [ "screenWidth()", 2, "div()" ] },
        "y" : { "calc" : [ "screenHeight()", 2, "div()" ] },
        "anchorX" : { "val" : 0.5 },
        "anchorY" : { "val" : 0.5 },
        "width" :  { "val" : 250 },
        "height" : { "val" : 70 },
        "fillColor" : { "val" : [0.7, 0.5, 0.3] }
      }
    }
  },
  {
    "fun" : {
      "name" : "createText",
      "params" : {
        "text" : { "val" : "Hello world!" },
        "x" : { "calc" : [ "screenWidth()", 2, "div()" ] },
        "y" : { "calc" : [ "screenHeight()", 2, "div()" ] },
        "anchorX" : { "val" : 0.5 },
        "anchorY" : { "val" : 0.5 },
        "fillColor" : { "val" : [0.9] },
        "fontSize" : { "val" : 32 }
      }
    }
  },
  {
    "fun" : {
      "name" :"setTemplate",
      "params" : {
        "template" : { "val" : "inventory"}
      }
    }
  }
]
```

## Usage

It's a CoronaSDK project with specs that can execute via `busted`.

More documentation coming soon.
