return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local lualine = require("lualine")

			-- Neotest status component
			local function neotest_status()
				local neotest = require("neotest")
				local status = neotest.status and neotest.status.status()

				if not status or status == "" then
					return ""
				end

				local results = neotest.status.results()
				if not results then
					return status
				end

				local passed, failed, running = 0, 0, 0
				for _, result in pairs(results) do
					if result.status == "passed" then
						passed = passed + 1
					elseif result.status == "failed" then
						failed = failed + 1
					elseif result.status == "running" then
						running = running + 1
					end
				end

				local parts = {}
				if passed > 0 then
					table.insert(parts, "✅ " .. passed)
				end
				if failed > 0 then
					table.insert(parts, "❌ " .. failed)
				end
				if running > 0 then
					table.insert(parts, "⏱ " .. running)
				end

				return table.concat(parts, " ")
			end

			lualine.setup({
				options = {
					theme = "auto",
					section_separators = "",
					component_separators = "",
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff" },
					lualine_c = { "filename" },
					lualine_x = { neotest_status, "encoding", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
			})
		end,
	},
}
