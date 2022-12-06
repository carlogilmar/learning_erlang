-module(event).
-compile(export_all).
-record(state, {server,
                name="",
                to_go=0}).

loop(State = #state{server=ServerPid}) ->
  receive
    {ServerPid, Ref, cancel} ->
      ServerPid ! {Ref, "Event Canceled OK"}
  after State#state.to_go*1000 ->
          ServerPid ! {done, State#state.name}
  end.

create_event(ServerPid, ServerName, Duration) ->
  spawn(?MODULE, loop, [#state{server=ServerPid, name=ServerName, to_go=Duration}]).

cancel(EventPid) ->
  %% You can monitor the process to know if the process is still alive
  EventPid ! {self(), make_ref(), cancel}.

%% How to run this code?
%% 15> c(event).
%% event.erl:2:2: Warning: export_all flag enabled - all functions will be exported
%% {ok,event}
%%
%% 16> Event3 = event:create_event(self(), "Evento 1", 1000).
%% <0.118.0>
%%
%% 17> event:cancel(Event3).
%% {<0.102.0>,#Ref<0.3373949135.2951217153.177640>,cancel}
%%
%% 18> flush().
%% Shell got {#Ref<0.3373949135.2951217153.177640>,"Event Canceled OK"}
%% ok
