set timeoutlen=200

lua <<EOF
local wk = require("which-key")

wk.register({
    b = { name = "buffer" },
    c = {
        name = "code",
        t = { name = "test" }
    },
    g = { name = "git" },
    t = { name = "toggle" },
}, { prefix = "<leader>" })
EOF
