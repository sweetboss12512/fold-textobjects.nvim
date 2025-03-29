## Installation

With Lazy:
```lua
return {
    "sweetboss12512/fold-textobjects.nvim", 
	keys = {
        {
            mode = { "o", "x" },
            "iz",
            function()
                require("fold-textobjects").inside_fold()
            end,
            desc = "inner fold",
        },
        {
            mode = { "o", "x" },
            "az",
            function()
                require("fold-textobjects").around_fold()
            end,
            desc = "outer fold",
        },
    }
}
```

## Why?
I wanted to select a #region comment but I couldn't.
