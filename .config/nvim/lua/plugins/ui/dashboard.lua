# File for the configuration of alpha-nvim (A dashboard for neovim)

return
{
    'goolord/alpha-nvim',
    config = function ()
        require'alpha'.setup(require'alpha.themes.dashboard'.config)
    end
};
