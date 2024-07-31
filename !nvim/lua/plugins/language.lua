---@type LazyPluginSpec[]
return {
	{
		'b0o/SchemaStore.nvim',
		lazy = true,
		dependencies = {
			{

				'AstroNvim/astrolsp',
				---@type AstroLSPOpts
				opts = {
					---@diagnostic disable: missing-fields
					config = {
						yamlls = {
							on_new_config = function(config)
								config.settings.yaml.schemas = vim.tbl_deep_extend(
									'force',
									config.settings.yaml.schemas or {},
									require('schemastore').yaml.schemas()
								)
							end,
							settings = { yaml = { schemaStore = { enable = false, url = '' } } },
						},
						jsonls = {
							on_new_config = function(config)
								if not config.settings.json.schemas then config.settings.json.schemas = {} end
								vim.list_extend(config.settings.json.schemas, require('schemastore').json.schemas())
							end,
							settings = { json = { validate = { enable = true } } },
						},
					},
				},
			},
		},
	},
	-- {
	-- 	'linux-cultist/venv-selector.nvim',
	-- 	branch = 'regexp',
	-- 	dependencies = {
	-- 		{ 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },
	-- 	},
	-- 	opts = {},
	-- 	cmd = 'VenvSelect',
	-- },
}
