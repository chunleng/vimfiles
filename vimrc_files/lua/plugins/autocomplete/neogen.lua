local function setup()
	local neogen = require("neogen")
	local languages_supported = { "python", "lua", "rust" }
	local convention = {}

	for _, language in ipairs(languages_supported) do
		local lang_convention = os.getenv("VIMCUSTOM_DOCSTRING_CONV" .. string.upper(language))
		if lang_convention ~= nil then
			convention[language] = {
				template = { annotation_convention = lang_convention },
			}
		end
	end

	neogen.setup({
		snippet_engine = "luasnip",
		placeholders_text = {
			description = "[desc]",
			tparam = "[param]",
			parameter = "[param]",
			["return"] = "[return]",
			class = "[class]",
			throw = "[throws]",
			varargs = "[args]",
			type = "[type]",
			attribute = "[attr]",
			args = "[args]",
			kwargs = "[args]",
		},
		languages = convention,
	})
end
return {
	{
		-- https://github.com/danymat/neogen
		"danymat/neogen",
		dependencies = { "L3MON4D3/LuaSnip" },
		config = setup,
	},
}
