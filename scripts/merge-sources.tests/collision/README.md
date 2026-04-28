# [array](./array/)

The [array](./array/) test demonstrates that arrays are concatened in the order that they are encountered.

# [object](./object/)

The [object](./object/) test demonstrates that objects are merged in alphabetical key order. 

# [primitive](./primitive/) and [nested-primitive](./nested-primitive/)

The tests for `primitive` and `nested-primitive` demonstrate that in the case of a key collision on a primitive value, the first encountered value will be preserved. 

> NOTE: This is due to our use of [jq's alternative operator](https://jqlang.org/manual/#alternative-operator) (`//`) within our merge function defined in [merge-sources.sh](../../merge-sources.sh).