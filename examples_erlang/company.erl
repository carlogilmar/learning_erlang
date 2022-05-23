-module(company).
-export([init/0, insert_emp/3, mk_projs/2, create_emp/0]).

-include_lib("stdlib/include/qlc.hrl").
-include("company.hrl").

init() ->
	mnesia:create_table(employee,
											[{attributes, record_info(fields, employee)}]),
	mnesia:create_table(dept,
											[{attributes, record_info(fields, dept)}]),
	mnesia:create_table(project,
											[{attributes, record_info(fields, project)}]),
	mnesia:create_table(manager, [{type, bag},
																{attributes, record_info(fields, manager)}]),
	mnesia:create_table(at_dep,
											[{attributes, record_info(fields, at_dep)}]),
	mnesia:create_table(in_proj, [{type, bag},
																{attributes, record_info(fields, in_proj)}]).

insert_emp(Emp, DeptId, ProjNames) ->
	Ename = Emp#employee.name,
	Fun = fun() ->
						mnesia:write(Emp),
						AtDep = #at_dep{emp = Ename, dept_id = DeptId},
						mnesia:write(AtDep),
						mk_projs(Ename, ProjNames)
				end,
	mnesia:transaction(Fun).


mk_projs(Ename, [ProjName|Tail]) ->
	mnesia:write(#in_proj{emp = Ename, proj_name = ProjName}),
	mk_projs(Ename, Tail);
mk_projs(_, []) -> ok.

create_emp() ->
	Emp  = #employee{emp_no= 104732,
									 name = klacke,
									 salary = 7,
									 sex = male,
									 phone = 98108,
									 room_no = {221, 015}},
	insert_emp(Emp, 'B/SFR', [erlang, mnesia, otp]).
