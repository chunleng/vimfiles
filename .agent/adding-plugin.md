## Adding a Plugin

`vimrc_files/lua/plugins/<category>/<plugin>.lua`:

```lua
local function setup()
	-- keymaps, autocmds, highlights
end

return {
	{
		-- https://github.com/author/plugin-name
		"author/plugin-name",
		config = setup,
		dependencies = { "dep/plugin" },
	},
}
```

In `<category>.lua` add:

```lua
{ import = "plugins.<category>.<plugin>" },
```

New category → create both:
- `vimrc_files/lua/plugins/<category>.lua`
- `vimrc_files/lua/plugins/<category>/<plugin>.lua`
