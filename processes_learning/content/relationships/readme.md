# Process Relationships

# Links

> A link is a specific kind of relationship that can be created between two processes. When that relationship is set up and one of the processes dies from an unexpected throw, error or exit (see Errors and Exceptions), the other linked process also dies.

- Links can not be stacked.
- If the process that has an error crashes but those that depend on it don't, then all these depending processes now have to deal with a dependency disappearing.
- Letting them die and then restarting the whole group is usually an acceptable alternative. Links let us do exactly this.
- To set a link between two processes, Erlang has the primitive function link/1.
- To get rid of a link, use unlink/1.
- For atomic operations we can use `spawn_link`.
- But the new process doesn’t know its parent process unless this information is passed to it somehow.

# Trap exit signals

- Error propagation across processes is done through a process similar to message passing, but with a special type of message called signals.
- Exit signals are 'secret' messages that automatically act on processes, killing them in the action.
- In order to restart a process, we need a way to first know that it died. This can be done by adding a layer on top of links (the delicious frosting on the cake) with a concept called system processes.
- System processes are basically normal processes, except they can convert exit signals to regular messages.
- By writing programs using system processes, it is easy to create a process whose only role is to check if something dies and then restart it whenever it fails.

# Monitors

Monitors are a special type of link with two differences:

- they are unidirectional.
- they can be stacked.

