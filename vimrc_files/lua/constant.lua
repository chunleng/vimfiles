local nodejs_version = "24.10.0"
return {
	NODEJS_PATH = vim.env.HOME .. "/.asdf/installs/nodejs/" .. nodejs_version .. "/bin",
	NODEJS_MODULES = vim.env.HOME .. "/.asdf/installs/nodejs/" .. nodejs_version .. "/lib/node_modules",
	PYTHON_PATH = vim.env.HOME .. "/.asdf/installs/python/3.12.11/bin",
	RUST_PATH = vim.env.HOME .. "/.asdf/installs/rust/1.88.0/toolchains/1.88.0-aarch64-apple-darwin/bin",
	JAVA_HOME = vim.env.HOME .. "/.asdf/installs/java/adoptopenjdk-21.0.0+35.0.LTS",
}
