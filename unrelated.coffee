util = require 'util'

realTypeOf = (o) ->
  if o is null
    'null'
  else if Array.isArray o
    'array'
  else
    typeof o

# foo: bar, baz, bumble: quux -> [{name: 'foo', info: [bar, baz]}, ...]
fancyArgs = (args) ->
  ret = []
  subject = null

  addSubject = (x) ->
    ret.push subject if subject
    ret.push x       if x

  for arg in args
    if 'object' is argType = realTypeOf arg
      addSubject()

      entries = Object.entries arg
      [extra..., entry] = entries
      extra.forEach ([name, value]) -> addSubject {name, values: [value]}
      subject = name: entry[0], values: [entry[1]]
    else
      if not subject
        throw new Error "Invalid fancy args: #{argType} before object:\n#{util.inspect args}"

      subject.values.push arg

  addSubject()
  return ret

tasks = (args...) ->
  for {name, values} in fancyArgs args
    [first..., impl] = values

    task name, (options) ->
      invoke task for task in first

      impl options

Object.assign module.exports, {tasks}
