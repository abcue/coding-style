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
	// ALIAS and LET in abbreviation of uppercase initials.
	// ALIAS should only be referred in a limited scope near definition
	let FN = name + "-suffix"
	name: N
	fullName: FN
}

instances: [
	// Loop index, key, values in abbreviation of lowercase initials.
	for _, i in instance {i}
]

// Specially
#Terraform: [=~#Style.snake_case]: _
