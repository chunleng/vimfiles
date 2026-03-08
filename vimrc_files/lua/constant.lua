local java_version = "adoptopenjdk-21.0.0+35.0.LTS"
local nodejs_version = "24.10.0"
local python_version = "3.12.11"
local uv_version = "0.10.4"
return {
	NODEJS_VERSION = nodejs_version,
	NODEJS_PATH = vim.env.HOME .. "/.asdf/installs/nodejs/" .. nodejs_version .. "/bin",
	NODEJS_MODULES = vim.env.HOME .. "/.asdf/installs/nodejs/" .. nodejs_version .. "/lib/node_modules",
	PYTHON_PATH = string.format("%s/.asdf/installs/python/%s/bin", vim.env.HOME, python_version),
	PYTHON_VERSION = python_version,
	UV_VERSION = uv_version,
	RUST_PATH = vim.env.HOME .. "/.asdf/installs/rust/1.94.0/toolchains/1.94.0-aarch64-apple-darwin/bin",
	JAVA_VERSION = java_version,
	JAVA_HOME = vim.env.HOME .. "/.asdf/installs/java/" .. java_version,
}
