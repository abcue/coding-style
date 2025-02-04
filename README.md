# Coding Style

Self described in [coding-style.cue](./coding-style.cue)

## Patterns

Try out in <https://cuelang.org/play/> to understand how it works.

### `[N=_]`

```cue
application: [N=_]: {
  name: N
}
```

The constraint above defines a struct with field `name` equals the key.

* `_` is the [top](https://cuelang.org/docs/references/spec/#top) value, basically it means no constraint.
* `N`is an [alias](https://cuelang.org/docs/references/spec/#aliases) which we may use as a reference to the value.
* `[]` is [pattern](https://cuelang.org/docs/references/spec/#pattern-and-default-constraints), it define constraints that apply to a collection of fields.

### `(N)`

Expression

```cue
let N="myapp"
application: (N): _
```

results in

```cue
application: "myapp": _
```

`(N)` is a [dynamic field](https://cuelang.org/docs/references/spec/#dynamic-fields)  whose label is determined by an expression.

### `if X != _|_ {}`

Expression

```cue
deploy: chart: _
if deploy.chart.build != _|_ {
  application: build: deploy.chart.build
}
```

results in

```cue
deploy: {
 chart: _
}
```

* `_|_` is the [bottom](https://cuelang.org/docs/references/spec/#bottom-and-errors) value. Any evaluation error in CUE results in a bottom value.
* `if` defines [conditional fields](https://cuelang.org/docs/tutorials/tour/expressions/conditional/).

### `#D & {...}` vs `{ #D }`

```cue
#App: {
  name: string
}

app: #App & {
  name: "myapp"
}

appWithVersion: {
  #App
  version: "1.0.0"
}

// appWithVersion.version: field not allowed:
// appWithVersion: #App & {
//  #App
//  version: "1.0.0"
// }
```

* `#` defines a [definition](https://cuelang.org/docs/references/spec/#definitions-and-hidden-fields) that [closes](https://cuelang.org/docs/references/spec/#closed-structs) a struct to forbid unknown fields.
* `&` is a [unification](https://cuelang.org/docs/references/spec/#unification) of `#App` with a concrete value for the field `name`.
* `{ A }` is a struct contains an [embedded](https://cuelang.org/docs/references/spec/#embedding) value bypassing the definition restrict to add field `version`.

### `*d | (d & {k: v})`

Override default conditionally

```cue
*r | (r & {expr: strings.Replace(r.expr, T, "\(#var.alerts.threshold[r.alert][strings.ToLower(r.labels.severity)])", -1)})
```

* Default to r when `#var.alerts.threshold[r.alert][strings.ToLower(r.labels.severity)]` evals to `_|_`

## Appendix

Documents

* [Tour](https://cuelang.org/docs/tour/) - good first reading
* [Kubernetes tutorial](https://github.com/cue-lang/cue/tree/master/doc/tutorial/kubernetes)
* [The CUE Language Specification](https://github.com/cue-lang/cue/blob/master/doc/ref/spec.md) - worth weeks of deep dive to understand the philosophy of CUE
* [_Cuetorials
](https://cuetorials.com) - many useful patterns

CUE in upstream

* <https://github.com/tnarg/rules_cue> - current bazel rules for cue in git-av/maglev
* <https://github.com/tnarg/cue_terraform>  - current tooling for terraform with cue
* <https://github.com/seh/rules_cue> - a more featureful set of bazel rules for cue
