if vim.fn.executable('wl-copy') == 1 and vim.fn.executable('wl-paste') == 1 then
  vim.g.clipboard = {
    name = 'wl-clipboard',
    copy = {
      ['+'] = 'wl-copy --foreground --type text/plain',
      ['*'] = 'wl-copy --foreground --type text/plain',
    },
    paste = {
      ['+'] = 'wl-paste --no-newline',
      ['*'] = 'wl-paste --no-newline',
    },
    cache_enabled = false,
  }
end
