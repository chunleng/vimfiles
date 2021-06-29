local wk = require("which-key")

wk.register({
    b = { name = "buffer" },
    c = { name = "code" },
    g = { name = "git" },
    t = { name = "toggle" },
}, { prefix = "<leader>" })
