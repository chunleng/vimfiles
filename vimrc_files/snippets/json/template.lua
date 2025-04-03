local M = {}

table.insert(
	M,
	s(
		{
			trig = "----typescriptreact/tsconfig",
			dscr = "Template for tsconfig.json",
		},
		fmta(
			[[
	// For TypeScript 4.4.3
	{
		"compilerOptions": {
			"target": "es5",
			"baseUrl": "./",
			"module": "esnext",
			"moduleResolution": "node",

			"removeComments": true,
			"esModuleInterop": true,
			"forceConsistentCasingInFileNames": true,
			"jsx": "react-jsx",

			"strict": true,

			"skipLibCheck": true,
			"resolveJsonModule": true,
			"allowJs": true,
			"noEmit": true,
			"isolatedModules": true,
			"allowSyntheticDefaultImports": true,
			"lib": ["dom", "dom.iterable", "esnext"]
		},
		"include": ["**/*.ts", "**/*.tsx"${1:, ...}],
		"exclude": ["node_modules"]
	}
]],
			{}
		)
	)
)

table.insert(
	M,
	s(
		{
			trig = "----typescriptreact/eslint",
			dscr = "Template for TypeScript React ESLint",
		},
		fmta(
			[[
	// `yarn add -D` or `npm i --save-dev`
	//   eslint @typescript-eslint/parser @typescript-eslint/eslint-plugin eslint-config-prettier eslint-plugin-prettier eslint-plugin-react eslint-plugin-react-hooks eslint-plugin-jsx-a11y
	// `yarn add -D -E` or `npm i --save-dev -E`
	//   prettier
	{
		"root": true,
		"env": {
			"browser": true,
			"es2021": true
		},
		"extends": [
			"eslint:recommended",
			"plugin:react/recommended",
			"plugin:react/jsx-runtime",
			"plugin:react-hooks/recommended",
			"plugin:jsx-a11y/recommended",
			"plugin:@typescript-eslint/eslint-recommended",
			"plugin:@typescript-eslint/recommended",
			"plugin:@typescript-eslint/recommended-requiring-type-checking",
			"plugin:prettier/recommended"
		],
		"parser": "@typescript-eslint/parser",
		"parserOptions": {
			"ecmaFeatures": {
				"jsx": true
			},
			"ecmaVersion": 12,
			"sourceType": "module",
			"project": "./tsconfig.json"
		},
		"plugins": [],
		"rules": {}
	}
]],
			{}
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "----kulala/http-client/init", dscr = "Template for Kulala http-client.env.json" },
		fmta(
			[[
{
	"$schema": "https://raw.githubusercontent.com/mistweaverco/kulala.nvim/main/schemas/http-client.env.schema.json",
	"$shared": {
		"$default_headers": {
			"Content-Type": "application/json",
			"Accept": "application/json"
		},
		"var_foo": "bar"
	},
	"dev": {
		"URL": "http://localhost:3000"
	}
}
]],
			{}
		)
	)
)

return M
-- vim: noet
