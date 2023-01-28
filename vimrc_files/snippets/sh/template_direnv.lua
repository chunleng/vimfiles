local M = {}

table.insert(M, s(
                 {
        trig = '?direnv/virtualenv',
        dscr = 'Template for virtualenv setup'
    }, fmta([[
	# Since we are expecting the virtualenv to be in the same folder,
	# we need to make poetry create the virtualenv in the same folder by doing the following
	#   poetry config virtualenvs.in-project true
	export VIRTUAL_ENV=`pwd`/.venv
	export PATH=${VIRTUAL_ENV}/bin:${PATH}
]], {})))

table.insert(M, s({
    trig = '?direnv/dockerenv_setting',
    dscr = 'Template for program where docker host is read instead of docker context (Like scaffold)'
}, fmta([[
    export DOCKER_HOST=$(docker context inspect <> -f '{{ .Endpoints.docker.Host }}')
]], {i(1)})))

table.insert(M, s({
    trig = '?vim/docstring_convention',
    dscr = 'Template for the docstring convention to use'
}, fmta([[
	# https://github.com/danymat/neogen#supported-languages
	DOC_CONV_<> = '<>'
]], {i(1), i(2)})))

return M
-- vim: noet
