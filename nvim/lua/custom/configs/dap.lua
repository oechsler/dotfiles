local dap = require('dap')
local dapui = require('dapui')

dap.adapters['pwa-node'] = {
  type = 'server',
  host = '127.0.0.1',
  port = 8123,
  executable = {
    command = 'js-debug-adapter',
  }
}

for _, lang in ipairs({'javascript', 'typescript'}) do
  dap.configurations[lang] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      cwd = "${workspaceFolder}",
      runtimeExecutable = "node",
    },
  }
end

vim.fn.sign_define("DapBreakpoint", {
  text = '',
  texthl = 'DiagnosticSignError',
  linehl = '',
  numhl = '',
})

vim.fn.sign_define("DapBreakpointRejected", {
  text = '',
  texthl = 'DiagnosticSignError',
  linehl = '',
  numhl = '',
})

vim.fn.sign_define("DapStopped", {
  text = '',
  texthl = 'DiagnosticSignWarn',
  linehl = 'Visual',
  numhl = 'DiagnosticSignWarn',
})

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end

dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
