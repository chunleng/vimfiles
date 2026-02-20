local M = {}

table.insert(
	M,
	s(
		{ trig = "----mcp/init", dscr = "Template for .mcp.json" },
		fmta(
			[[
	{
		"servers": {
			<>
		}
	}
]],
			{ i(0) }
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "----mcp/github", dscr = "Add GitHub remote MCP" },
		fmta(
			[[
	"github": {
		"type": "http",
		"url": "https://api.githubcopilot.com/mcp/",
		"autoApprove": [
			"issue_read",
			"list_commits",
			"list_issues",
			"pull_request_read",
			"search_issues",
			"search_pull_requests",
			"list_pull_requests"
		],
		"disabled_prompts": [
			"AssignCodingAgent",
			"issue_to_fix_workflow"
		],
		"disabled_resourceTemplates": [
			"repo://{owner}/{repo}/contents{/path*}",
			"repo://{owner}/{repo}/refs/heads/{branch}/contents{/path*}",
			"repo://{owner}/{repo}/refs/pull/{prNumber}/head/contents{/path*}",
			"repo://{owner}/{repo}/refs/tags/{tag}/contents{/path*}",
			"repo://{owner}/{repo}/sha/{sha}/contents{/path*}"
		],
		"disabled_tools": [
			"create_branch",
			"assign_copilot_to_issue",
			"create_or_update_file",
			"create_repository",
			"delete_file",
			"fork_repository",
			"get_commit",
			"get_file_contents",
			"get_label",
			"get_latest_release",
			"get_me",
			"get_release_by_tag",
			"get_tag",
			"get_team_members",
			"get_teams",
			"request_copilot_review",
			"search_code",
			"search_repositories",
			"search_users",
			"list_tags",
			"list_branches",
			"list_issue_types",
			"list_commits",
			"list_releases",
			"push_files"
		],
		"headers": {
			"Authorization": "Bearer <>"
		}
	}
]],
			{ i(0) }
		)
	)
)

return M
-- vim: noet
