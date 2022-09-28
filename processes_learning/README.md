![image](https://user-images.githubusercontent.com/17634377/169910811-c5ae0eaa-7739-41a7-913f-563f0f2c9a56.png)

# The BEAM Atlas Log's

Content:

1. Processes
2. Erlang Shell
3. Message Passing
4. Links
5. Exit Signals and System Processes
6. Monitors

# 🔵 Part 1 Processes

## 🔵 1.1 Process

> ⭐️ A process in Erlang is an isolated entity to execute code. It's a single unit of failure.

Process creation:

```erlang
1> F = fun() -> 2 + 2 end.
#Fun<erl_eval.20.67289768>

2> spawn(F).
<0.44.0>

3> spawn(fun() -> io:format("~p~n",[2 + 2]) end).
4
<0.46.0>
```

- Use the function SPAWN to create a new process with a given function.
- This process will have a **process identifier PID** to represent that this process exists in the VM´s life.
- A process execute code inside, but the creation doesn’t return nothing more than the PID.
- The process will execute the code inside then to be created.
- The processes creation is managed by the VM. This allows the parallelism.
- The shell is a process  **self()**

Life Cycle:

- Creation using **spawn**
- Execute the given code
- Terminating

## 🔵 1.2 Erlang Shell ERL

```erlang
Erlang/OTP 24 [erts-12.1.1] [source] [64-bit] [smp:10:10] [ds:10:10:10] [async-threads:1]
```

Erl info:

1. Version: *Erlang/OTP 24* 
2. Symmetric multiprocessing: *smp*
3. Cores availables/Schedulers available: *[smp:2:2]*
4. SMP disabled, Run queues: *[rq:2]*

## 🔵 1.3 Message Passing 

```erlang
9> self() ! hello.
hello
```

- Every process has a **MAILBOX** to receive messages
- Every process is able to send messages using the **PID** and the bang operator **!**
- You can use the **flush().** to see the mailbox content (messages received)
- The mailbox is used to receive the messages while we need to execute inside the clause **receive** to process the messages
- You can execute your code in the  **receive** clause
- The  **receive** clause allows you to wait for receive a message, as this allows to keep the state and keep alive the process.
- You can put a timeout in the  **receive** clause to prevent process frozen when you receive a weird message.

## 🔵 1.4 Links between processes

- A link is a relationship between two process.
- You can use **link** / **unlink** functions
- For atomic operations use **spawn_link**
- When a linked process dies the error is propagated to the other process. If the process dies, the linked process will die.
- It’s useful to establish processes that should all die together.
- It’s a bidirectional relationship, cannot be stacked, just 1.

```erlang
1> c(linkmon).
{ok,linkmon}
2> spawn(fun linkmon:myproc/0).
<0.52.0>
3> link(spawn(fun linkmon:myproc/0)).
true
** exception error: reason
```

## 🔵 1.5 Exit Signals and System Processes

> ⭐️ **Exit signals** are secret messages that act on processes kill them in the action
  
> ⭐️ **System Processes** are processes that can convert exit signals to regular messages

- Error propagation across processes are thanks to the exit signals
- To convert a process into a system process, we need to call **process_flag/2**
- Then to use the **process_flag/2** your process will receive just **exit signals** in his **receive** clause.
- This prevents the error propagation in the system process.

## 🔵 1.6 Monitor

> **⭐️ A monitor** is a unidirectional relationship between two process

- You can stack many monitors
- Use it to know what’s going on a process
- The monitor relationship has a reference ID
- When the process goes down, you monitor receive the message.
