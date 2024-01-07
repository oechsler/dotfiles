local M = {}

M.dap = {
  n = {
    ['<leader>dt'] = {
      function ()
        require('dap').toggle_breakpoint()
      end,
      'Toggle Breakpoint',
    },
    ['<leader>db'] = {
      function ()
        require('dap').step_back()
      end,
      'Step Back',
    },
    ['<leader>dc'] = {
      function ()
        require('dap').continue()
      end,
      'Continue',
    },
    ['<leader>dC'] = {
      function ()
        require('dap').run_to_cursor()
      end,
      'Run To Cursor',
    },
    ['<leader>dd'] = {
      function ()
        require('dap').disconnect()
      end,
      'Disconnect',
    },
    ['<leader>dg'] = {
      function ()
        require('dap').session()
      end,
      'Get Session',
    },
    ['<leader>di'] = {
      function ()
        require('dap').step_into()
      end,
      'Step Into',
    },
    ['<leader>do'] = {
      function ()
        require('dap').step_over()
      end,
      'Step Over',
    },
    ['<leader>du'] = {
      function ()
        require('dap').step_out()
      end,
      'Step Out',
    },
    ['<leader>dp'] = {
      function ()
        require('dap').pause()
      end,
      'Pause',
    },
    ['<leader>dr'] = {
      function ()
        require('dap').repl.toggle()
      end,
      'Toggle Repl',
    },
    ['<leader>ds'] = {
      function ()
        require('dap').continue()
      end,
      'Start',
    },
    ['<leader>dq'] = {
      function ()
        require('dap').close()
      end,
      'Quit',
    },
    ['<leader>dU'] = {
      function ()
        require('dapui').toggle({reset = true})
      end,
      'Toggle UI',
    },
  },
}

M.rustaceanvim = {
  plugin = true,
  n = {
    ['<leader>ds'] = {
      '<cmd> RustLsp debuggables <CR>',
      'Start',
    },
  }
}

M.hop = {
  -- Normal mode
  n = {
    ['<leader><leader>W'] = {
      '<cmd> HopWord <CR>',
      'Hop to word',
    },
    ['<leader><leader>L'] = {
      '<cmd> HopLine <CR>',
      'Hop to line',
    },
  },

  -- Visual mode
  v = {
    ['<leader><leader>W'] = {
      '<cmd> HopWord <CR>',
      'Select to word',
    },
    ['<leader><leader>L'] = {
      '<cmd> HopLine <CR>',
      'Select to line',
    },
  },
}

return M
