local M = {}

table.insert(
	M,
	s(
		{ trig = "?erd", dscr = "A new template for ERD diagram" },
		fmta(
			[[
	@startuml
	' https://plantuml.com/ie-diagram
	title <>

	' hide the spot
	hide circle

	' avoid problems with angled crows feet
	skinparam linetype ortho

	entity owner {
		🔑id: number
		--
		* age: number
		* weight: decimal
	}

	entity animal {
		🔑id: number
		--
		* owner_id: number <<FK>>
		* not_null: text
		null: text
		default: number (default: 0)
	}

	owner ||-ri-o{ animal

	' }|--o| Cardinality and Optionality
	' ||-ri-|| With direction: up/do/le/ri
	@enduml
]],
			{ i(1, "Title") }
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "?erd/table", dscr = "A new ERD table" },
		fmta(
			[[
	entity <> {
		🔑id: number
		--
		<>
	}
]],
			{
				i(1, "table_name"),
				i(2, {
					"* owner_id: number <<FK>>",
					"\t* not_null: text",
					"\tnull: text",
					"\tdefault: number (default:0)",
				}),
			}
		)
	)
)

table.insert(
	M,
	s(
		{
			trig = "?sequence",
			dscr = "A new template for sequence diagram",
		},
		fmta(
			[[
	@startuml
	' https://plantuml.com/sequence-diagram
	title <>

	participant participant1
	actor actor1
	boundary boundary1
	control control1
	entity entity1
	database database1
	queue queue1

	participant1 ->> actor1 : To actor
	note right
		Multi-line
		notes
	end note

	alt case x
		participant1 ->> boundary1 : To boundary
	else case y
		participant1 ->> control1 : To control
	end

	loop 100 times
		participant1 ->> entity1 : To entity
	end

	participant1 ->> database1 : To database
	ref over participant1, actor1: some method
	activate participant1
	participant1 ->> queue1 : To queue
	return 1

	' Other way to place note and ref
	' note right: message
	' note across: message
	@enduml
]],
			{ i(1, "Title") }
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "?state", dscr = "A new template for state diagram" },
		fmta(
			[[
	@startuml
	' https://plantuml.com/state-diagram
	title <>

	hide empty description

	state drive {
		[*] -->> straight
		straight -ri->> right : [Steering wheel turn right]
		right -le->> straight
		straight -le->> left
		left -ri->> straight
		straight -->> [*]

		left : entry: turn wheel left
		left : do: spin the engine
		left : exit: turn wheel straight
	}

	note top of drive
		Watch where you're going!
	end note

	[*] -->> stop
	stop -ri->> drive
	drive -le->> stop
	stop -do->> [*]

	' -ri->> With direction: up/do/le/ri
	@enduml
]],
			{ i(1, "Title") }
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "?flowchart", dscr = "A new template for flowchart" },
		fmta(
			[[
	@startuml
	' https://plantuml.com/activity-diagram-beta
	title <>

	' for vertical ifs
	!pragma useVerticalIf on

	start
	:Task 1;
	if (Condition) then (true)
		:Task 2;
	else (no)
		:Task 3;
	endif

	while (Condition)
	    :Task 4;
	endwhile

	fork
	    :Task 5;
	fork again
	    :Task 6;
	    note right: Comment
	endfork
	' Use below to merge the fork
	' end merge
	stop
	@enduml
]],
			{ i(1, "Title") }
		)
	)
)

table.insert(
	M,
	s(
		{ trig = "?c4model/context", dscr = "A new template for C4Model" },
		fmta(
			[[
	 @startuml
	' https://github.com/plantuml-stdlib/C4-PlantUML
	!include https://raw.githubusercontent.com/plantuml-stdlib/C4-PlantUML/master/C4_Container.puml

	' Disable type labels
	HIDE_STEREOTYPE()

	title <>

	!define DEVICONS https://raw.githubusercontent.com/tupadr3/plantuml-icon-font-sprites/master/devicons
	!define FONTAWESOME https://raw.githubusercontent.com/tupadr3/plantuml-icon-font-sprites/master/font-awesome-5
	!include DEVICONS/angular.puml
	!include DEVICONS/java.puml
	!include FONTAWESOME/users.puml


	Person(user, "Customer", "People that need products", $sprite="users", $link="https://www.example.com")
	System(spa, "SPA", "The main interface that the customer interacts with", $sprite="angular", $link="https://example.com")
	System(api, "API", "Handles all business logic", $sprite="java")
	SystemDb(db, "Database", "Holds product, order and invoice information", $sprite="img:https://uploads-ssl.webflow.com/5d1126db676120bb4fe43762/62d039f9fba316adad74afba_5ef3ad326275f228a47ff6af_sqlserver.png{scale=0.15}")

	Rel(user, spa, "Uses", "https")
	BiRel(spa, api, "Uses", "https")
	Rel_R(api, db, "Reads/Writes")

	SHOW_LEGEND()
	@enduml
]],
			{ i(1, "Title") }
		)
	)
)

return M
-- vim: noet
