package coding_style

#Style: {
	camelCase:    "^[a-z][a-zA-Z0-9]*$"
	PascalCase:   "^[A-Z][a-zA-Z0-9]*$"
	UPPER_CASE:   "^[A-Z][A-Z0-9_]*$"
	snake_case:   "^[a-z][a-z0-9_]*$"
	"kebab-case": "^[a-z][a-z0-9-]*$"
	lowercase:    "^[a-z][a-z0-9]*$"
}

package: name: =~#Style.snake_case

#var: [=~#Style.camelCase]:    _
_local: [=~#Style.camelCase]:  _
#output: [=~#Style.camelCase]: _

#Definition: _

instance: [N=~#Style.camelCase]: {
	let FN = name + "-suffix"
	name: N
	fullName: FN
}

// Specially
#Terraform: [=~#Style.snake_case]: _
