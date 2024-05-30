local M = {}

function f_get_upper_camel(args)
	return require("utils").snake_to_upper_camel(args[1][1])
end

table.insert(
	M,
	s(
		{
			trig = "?fastapi/init",
			dscr = "Template for FastAPI init",
		},
		fmta(
			[[
	from fastapi import FastAPI
	from fastapi.middleware.cors import CORSMiddleware
	from fastapi.responses import JSONResponse
	from pydantic import BaseModel

	app = FastAPI(docs_url=None, redoc_url=None, openapi_url=None)
	app.add_middleware(CORSMiddleware, allow_origins=['*'])
]],
			{}
		)
	)
)

table.insert(
	M,
	s(
		{
			trig = "?fastapi/function",
			dscr = "Template for FastAPI",
		},
		fmta(
			[[
@app.<>(
	'/<>',
	operation_id='<>',
	response_class=JSONResponse,
	response_model=Model,
	tags=[]
)
async def <>(<>):
	<>
]],
			{
				i(1, "get"),
				f(f_get_upper_camel, { 2 }),
				f(f_get_upper_camel, { 2 }),
				i(2, "foo"),
				i(3),
				i(0),
			}
		)
	)
)

table.insert(
	M,
	s(
		{
			trig = "?fastapi/model",
			dscr = "Template for FastAPI model",
		},
		fmta(
			[[
class <>(BaseModel):
	name: str
	description: Optional[str] = None
	price: float
	tax: Optional[float] = None
	tags: list = []
]],
			{ i(0, "Foo") }
		)
	)
)
return M
-- vim: noet
