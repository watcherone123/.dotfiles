return {
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    keys = {
      { "<leader>bb", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
      { "<leader>hk", "<cmd>FzfLua keymaps<cr>", desc = "Key Maps" },
      { "<leader>hM", "<cmd>FzfLua man_pages<cr>", desc = "Man Pages" },
      { "<leader>hh", "<cmd>FzfLua help_tags<cr>", desc = "Help Pages" },
      { "<leader>bt", "<cmd>FzfLua btags<cr>", desc = "Tags" },
      { "<leader>fd", "<cmd>FzfLua zoxide<cr>", desc = "change dir(zoxide)" },
      -- { "<M-x>", "<cmd>FzfLua commands<cr>", desc = "commands" },
      { "<leader>fF", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
      {
        "<leader>sb",
        "<cmd>FzfLua blines<cr>",
        desc = "Search buffer",
      },
      { "<leader>sB", "<cmd>FzfLua lines<cr>", desc = "Search all open buffers" },
      { "<leader>sp", LazyVim.pick("live_grep"), desc = "Search project" },
      { "<leader>sd", LazyVim.pick("live_grep", { root = false }), desc = "Search current directory" },
      { "<leader>sc", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
      {
        "<M-x>",
        function()
          local global_commands = vim.api.nvim_get_commands({})
          local buf_commands = vim.api.nvim_buf_get_commands(0, {})

          local utils = require("fzf-lua.utils")
          local core = require("fzf-lua.core")
          local config = require("fzf-lua.config")
          local hf_util = require("config.utils")
          local opts = nil
          opts = {
            include_builtin = true,
            sort_lastused = true,
            reverse_list = true,
          }
          opts = config.normalize_opts(opts, "commands")
          if not opts then
            return
          end
          local builtin_commands = {}
          local hist_commands = {}

          -- parse help doc to get builtin commands and descriptions
          if opts.include_builtin then
            local help = vim.fn.globpath(vim.o.rtp, "doc/index.txt")
            if vim.uv.fs_stat(help) then
              local cmd, desc
              for line in utils.read_file(help):gmatch("[^\n]*\n") do
                if line:match("^|:[^|]") then
                  if cmd then
                    builtin_commands[cmd] = desc
                  end
                  cmd, desc = line:match("^|:(%S+)|%s*%S+%s*(.*%S)")
                elseif cmd then -- found
                  if line:match("^%s+%S") then
                    local desc_continue = line:match("^%s*(.*%S)")
                    desc = desc .. (desc_continue and " " .. desc_continue or "")
                  end
                  if line:match("^%s*$") then
                    break
                  end
                end
              end
              if cmd then
                builtin_commands[cmd] = desc
              end
            end
          end

          local commands = vim.tbl_extend("force", {}, global_commands, buf_commands, builtin_commands)

          local entries = {}

          if opts.sort_lastused then
            -- display last used commands at the top of the list (#748)
            -- iterate the command history from last used backwards
            -- each command found gets added to the top of the list
            -- and removed from the command map
            local history = vim.split(vim.fn.execute("history cmd"), "\n")
            for i = #history, 1, -1 do
              local item = history[i]
              local _, finish = string.find(item, "%d+ +")
              if finish ~= nil then
                local ret = string.sub(item, finish + 1)
                hist_commands[ret] = history[i]
              end
              -- local cmd = history[i]:match("%d+%s+([^%s]+)")
              --
              -- if buf_commands[cmd] then
              --   table.insert(entries, cmd)
              --   buf_commands[cmd] = nil
              -- end
              -- if global_commands[cmd] then
              --   table.insert(entries, cmd)
              --   global_commands[cmd] = nil
              -- end
              -- if builtin_commands[cmd] then
              --   local item = history[i]
              --   local _, finish = string.find(item, "%d+ +")
              --   local ret = string.sub(item, finish + 1)
              --   table.insert(entries, ret)
              --   builtin_commands[cmd] = nil
              -- end
            end
          end

          for k, _ in pairs(global_commands) do
            table.insert(entries, utils.ansi_codes.blue(k))
          end

          for k, v in pairs(buf_commands) do
            if type(v) == "table" then
              table.insert(entries, utils.ansi_codes.green(k))
            end
          end

          -- Sort before adding "builtin" so they don't end up atop the list
          if not opts.sort_lastused then
            table.sort(entries, function(a, b)
              return a < b
            end)
          end

          for k, _ in pairs(builtin_commands) do
            table.insert(entries, utils.ansi_codes.magenta(k))
          end

          for k, _ in pairs(hist_commands) do
            table.insert(entries, opts.reverse_list and 1 or #entries + 1, utils.ansi_codes.magenta(k))
          end

          opts.preview = function(args)
            local cmd = args[1]
            if commands[cmd] then
              cmd = vim.inspect(commands[cmd])
            end
            return cmd
          end

          opts.actions = {
            ["enter"] = {
              fn = function(s)
                local ok, result = pcall(vim.api.nvim_exec2, s[1], { output = true })
                if not ok then
                  hf_util.warn("fzf-lua", result)
                end
              end,
            },
          }

          core.fzf_exec(entries, opts)
        end,
        desc = "commands",
      },
      {
        "<leader>sg",
        function()
          local fzf = require("fzf-lua")
          fzf.registers({
            actions = {
              ["enter"] = {
                fn = function(s)
                  local reg = s[1]:match("%[(.-)%]")
                  local ok, data = pcall(vim.fn.getreg, reg)
                  if ok and #data > 0 then
                    fzf.live_grep({
                      search = data,
                    })
                  end
                end,
              },
            },
          })
        end,
        desc = "Search with registers",
      },
      {
        "<leader>ff",
        function()
          local fzf = require("fzf-lua")
          local path = fzf.path
          local current_dir = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":h")
          local utils = require("config.utils")
          local cur_path = nil
          local function find_files(dir)
            fzf.files({
              cwd = dir,
              fd_opts = [[--color=never --hidden --type f --type d --max-depth 1 --exclude .git]],
              actions = {
                ["enter"] = {
                  fn = function(s)
                    if cur_path == nil then
                      cur_path = current_dir
                    end
                    local s_path = path.normalize(cur_path .. "/" .. s[1])
                    if utils.check_path_type(s_path) == 1 then
                      utils.zcd(s_path)
                      vim.cmd(":Yazi cwd")
                    else
                      if utils.check_path_type(s_path) == 2 then
                        utils.zcd(cur_path)
                        vim.cmd("edit " .. vim.fn.fnameescape(s_path))
                      else
                        utils.zcd(cur_path)
                        vim.cmd(":Yazi cwd")
                      end
                    end
                    cur_path = nil
                  end,
                },
                ["BS"] = {
                  fn = function(_)
                    local parent_dir = path.normalize(vim.fn.fnamemodify(dir, ":h"))
                    if parent_dir ~= dir then
                      cur_path = parent_dir
                      find_files(parent_dir)
                    end
                  end,
                  description = "Open file in vertical split",
                  reload = true,
                },
                ["ctrl-l"] = {
                  fn = function(selected)
                    if selected[1] then
                      local selected_path = selected[1]
                      local full_path = path.remove_trailing(path.normalize(dir .. "/" .. selected_path))
                      if vim.fn.isdirectory(full_path) == 1 then
                        cur_path = full_path
                        find_files(full_path)
                      end
                    end
                  end,
                  reload = true,
                },
              },
            })
          end
          find_files(current_dir)
        end,
        desc = "Find files (Emacs style)",
      },
      { "<leader>fb", false },
      { "<leader>sa", false },
      { "<leader>sh", false },
      { "<leader>sk", false },
      { "<leader>sM", false },
      { "<leader>sC", false },
      { "<leader>sG", false },
      { "<leader>:", false },
      { "<leader>,", false },
      { '<leader>s"', false },
      { "<leader>sl", false },
      { "<leader><space>", false },
    },
    config = function()
      require("fzf-lua").setup({
        "ivy",
        files = {
          previewer = false,
          file_icons = false,
          git_icons = false,
        },
        oldfiles = {
          previewer = false,
          file_icons = false,
          git_icons = false,
        },
        buffers = {
          previewer = false,
          file_icons = false,
          git_icons = false,
        },
        zoxide = {
          previewer = false,
        },
        grep = {
          file_icons = false,
          git_icons = false,
        },
        lines = {
          file_icons = false,
          git_icons = false,
        },
        commands = {
          previewer = false,
          prompt = "M-x ",
          winopts = {
            height = 0.20,
          },
        },
      })
    end,
  },
}
