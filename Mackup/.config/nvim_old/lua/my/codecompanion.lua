return {
  dir = "/Users/maxpaulu/c/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    log_level = "DEBUG",
    adapters = {
      default = "bedrock",
    },
    strategies = {
      chat = {
        adapter = "bedrock",
      },
      inline = {
        adapter = "bedrock",
      },
      cmd = {
        adapter = "bedrock",
      },
    },
  },
}
