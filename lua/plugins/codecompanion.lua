return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },

    config = function()
        require("codecompanion").setup({
            strategies = {
                chat = {
                    adapter = "ollama",
                },
                inline = {
                    adapter = "ollama",
                },
            },

            adapters = {
                ollama = function()
                    return require("codecompanion.adapters").extend("ollama", {
                        env = {
                            url = "http://127.0.0.1:11434",
                        },
                        schema = {
                            model = {
                                default = "qwen2.5-coder:3b",
                            },
                        },
                    })
                end,
            },

            opts = {
                log_level = "DEBUG",
            },
        })
    end,
}
