# Programming Erlang

## Day 1 Jan, 19, 2021

## Basics

- Erlang Shell and (.) for evaluate sentences
- Integers
- Floats
- Math Operators
- Atoms `atomo.` `'soy atomo'.`
- Booleans
- Tuplas `{hola, soy, tupla}.`
- Lists `[hola,soy,lista]`
- Strings
    + There is no string data type
    + Are a list of ASCII values 
    + Denote by double quote `"I'm a string"` `[65,66,67]`

## Lists

- [head|[tail]] (tail is a list)
- `[1|[2,3,4,5]]`
- lists is a library module `lists:sort`

> BIF: Is a built-in function; BIFs are functions that are defined as part of the Erlang language. Some BIFs are implemented in Erlang, but most are implemented as primitive operations in the Erlang virtual machine.
> 

- Some operations: max, reverse, sort, split, sum, zip, delete, last, member, nth, `length([1, 2, 3]).`
- Operators `++` `--` (add and subtracts)

## Prop Lists

- Are ordinary lists but containing entries in the form of either tagged tuples
- `proplists` is a module with functions

## Term Comparison

- Term Comparison: normal comparation and data type comparation `1=:=1.0` or `1 =/= 1`
- Hierarchy: `number < atom < reference < fun < port < pid < tuple < list < binary`

## Variables

- Single assignment
- The concept of call by reference does not exist
- Global variables do not exist
- Dynamic Type System, types determinated in runtime
- Before using variables, remember: variables can be bound only once!
- Using f() forgets all variable bindings
- An excellent tool that resulted from research related to an Erlang
type system by Uppsala University is TypEr, which can infer types of Erlang functions (Dialyzer Tool)

```
23> Double = 2.
2
25> Double = Double+2.
** exception error: no match of right hand side value 4

26> f(Double).
ok
27> Double.
* 1: variable 'Double' is unbound
```

## Complex Data Structures

```
1> JoeAttributeList = [{shoeSize,42}, {pets,[{cat, zorro},{cat,daisy}]},
1> {children,[{thomas,21},{claire,17}]}].
[{shoeSize,42},
{pets,[{cat,zorro},{cat,daisy}]},
{children,[{thomas,21},{claire,17}]}]
```

## Memory Management

- there is no explicit need for memory allocation and deallocation 
- Memory to store the complex data types is allocated by the runtime system when needed, and deallocated automatically by the garbage collector when the structure is no longer referenced.
- Erlang products developed in 1993
- The VM automatically handles the task of allocating memory for the system, and more importantly, it recycles that memory when it is no longer needed (hence the term “garbage collection”).
- The current implementation of the Erlang VM uses a copying, generational garbage collector.
- A copying garbage collector works by having two separate areas (heaps) for storing data. When garbage collection takes place, the active memory is copied to the other heap, and the garbage left behind is overwritten in the other heap.
- The garbage collector is also generational, meaning that it has several generations of the heap (in Erlang’s case, two). A garbage collection can be shallow or deep.

## Pattern Matching

```
32> [head|tail] = List.
** exception error: no match of right hand side value
                    [1,2,3,4,5]
33> [Head|Tail] = List.
[1,2,3,4,5]

44> {Var1, Var2, Var3, Var4} = {hola, soy, tupla, atomos}.
45> Var1.
hola

49> {Var1, _, _, _} = {hola, soy, tupla, atomos}
```

## Functions 

- Functions have to be defined in modules and compiled separately.

``` erlang
area({square, Side}) ->
    Side * Side ;
area({circle, Radius}) ->
    math:pi() * Radius * Radius;
area({triangle, A, B, C}) ->
    S = (A + B + C)/2,
    math:sqrt(S*(S-A)*(S-B)*(S-C));
area(Other) ->
    {error, invalid_object}.
```

## Modules

- `.erl` suffix
- The export directive contains a list of exported functions of the format Function/Arity.
- Compilation and the Erlang Virtual Machine
    + It results a module.beam file
    + The .beam suffix stands for Björn’s Erlang Abstract Machine, an abstract machine on which the compiled code runs.

```
-module(demo).
-export([double/1]).

% This is a comment.
% Everything on a line after % is ignored.

double(Value) ->
    times(Value, 2).

times(X,Y) ->
    X*Y.
```

## Compilation

```
Eshell V10.6  (abort with ^G)
1> c(demo).
{ok,demo}
2> demo:
double/1       module_info/0  module_info/1
2> demo:module_info().
[{module,demo},
 {exports,[{double,1},
           {module_info,0},
           {module_info,1}]},
 {attributes,[{vsn,[292684572923778825849379501803311035483]}]},
 {compile,[{version,"7.5"},
           {options,[]},
           {source,"/Users/carlogilmar/Code/ErlangSolutions/erlang_learning/demo.erl"}]},
 {native,false},
 {md5,<<220,48,255,146,65,8,170,215,173,208,
        153,124,120,61,116,91>>}]
3> demo:double(5).
10
```

## Memory Efficienctly

> http://erlang.org/doc/efficiency_guide/advanced.html

# Day 2 Jan, 19, 2021

## Chapter 3

## Sequential Erlang

- Recursion is the most useful and powerful technique in a functional programmer's armony
- Runtime errors because Erlang doesn't have a string type system

##  Conditional Evaluations

### Case

```
case lists:member(1, [1, 2, 3, 4]) of
    true -> ok;
    false -> {error, unknown_element}
end.
```

```
index(X,Y) ->
    index({X,Y}).

index(Z) ->
    case Z of
        {0,[X|_]} -> X;
        {N,[_|Xs]} when N>0 -> index(N-1,Xs)
    end.
```

```
index(X,Y) ->
    case X of
        0 ->
            case Y of
                [Z|_] -> Z
            end;
        N when N>0 ->
            case Y of
                [_|Zs] -> index(N-1,Zs)
            end
    end.
```


## Variable Scope

- The scope of a variable is the region of the program in which that variable can be used.
- In Erlang the scope of a variable is any position in the same function clause
after it has been bound, either by an explicit match using = or as part of a pattern. This is considered bad coding practice, as it tends to make the code much harder to read and understand.

## If Construct

```
if
    X < 1 -> smaller;
    X > 1 -> greater;
    X == 1 -> equal;
    true -> error
end
```

## Guards

- Guards are additional constraints that can be placed in a function clause

```
factorial(N) when N > 0 ->
    N * factorial(N - 1);
factorial(0) -> 1.

```

```
guard2(X,Y) when not(X>Y) , is_atom(X) ; not(is_atom(Y)) , X=/=3.4 ->
X+Y.
```

## Built-In Functions

- BIFs are usually written in C and integrated into the virtual machine (VM), and can be used to manipulate, inspect, and retrieve data as well as interact with the operating system.
- Standard built-in functions are auto-imported, so you can call them without the module prefix.
- Nonstandard BIFs, however, have to be prefixed with the erlang module prefix, as in erlang:function.


## Object access

```
1> List = [one,two,three,four,five].
[one,two,three,four,five]
2> hd(List).
one
3> tl(List).
[two,three,four,five]
4> length(List).
5
5> hd(tl(List)).
two
6> Tuple = {1,2,3,4,5}.
{1,2,3,4,5}
7> tuple_size(Tuple).
5
8> element(2, Tuple).
2
9> setelement(3, Tuple, three).
{1,2,three,4,5}
10> erlang:append_element(Tuple, 6).
{1,2,3,4,5,6}
```

## Type Conversion

- atom_to_list/1, list_to_atom/1, list_to_existing_atom/1
- list_to_existing_atom/1 will fail.
- list_to_tuple/1, tuple_to_list/1
- float/1, list_to_float/1
- float_to_list/1, integer_to_list/1
- round/1, trunc/1, list_to_integer/

## Meta Programming: apply/3 function

- Args is always a list 

```
1> Module = examples.
examples
2> Function = even.
even
3> Arguments = [10].
[10]
4> apply(Module, Function, Arguments).
true

5> apply(sequential, listlen, [2,3,4]).
** exception error: undefined function sequential:listlen/3
6> apply(sequential, listlen, [[2,3,4]]).
```

### String interpolation

```
40> Str = "Mary had a ~B lamb".
"Mary had a ~B lamb"
41> lists:flatten( io_lib:format(Str, [1]) ).
"Mary had a 1 lamb"
```

### Atom interpolation

```
37> lists:map(fun(I)->
37>            list_to_atom(lists:flatten(io_lib:format("certfile~B", [I])))
37>          end, lists:seq(1,10)).
[certfile1,certfile2,certfile3,certfile4,certfile5,
 certfile6,certfile7,certfile8,certfile9,certfile10]
```

### Comprehensions

```
[ Idx+1 || Idx <- lists:seq(1, 10) ].
```

### My exercise

```
mnesia:transaction(fun() -> mnesia:write({user, username1, 26}) end).

48> list_to_atom(io_lib:format("certfile~B", [1])).
certfile1

53> [ list_to_atom(io_lib:format("user~B", [Idx])) || Idx <- lists:seq(1, 10)].
[user1,user2,user3,user4,user5,user6,user7,user8,user9,
 user10]

```

```
mnesia:transaction(fun() -> mnesia:write({user, , Idx}) end).

[ list_to_atom(io_lib:format("user~B", [Idx])) || Idx <- lists:seq(1, 10)].

[ mnesia:transaction(fun() -> mnesia:write({user, list_to_atom(io_lib:format("user~B", [Idx])), Idx}) end) || Idx <- lists:seq(1, 10)].
```

## Apply

```
1> Module = examples.
examples
2> Function = even.
even
3> Arguments = [10].
[10]
4> apply(Module, Function, Arguments).
true
```

## Print

Control sequences begin with a tilde (~), and the simplest form is a single character,
indicating the following:
~c
An ASCII code to be printed as a character.
~f
A float to be printed with six decimal places.
~e
A float to be printed in scientific notation, showing six digits in all.
~w
Writes any term in standard syntax.
~p
Writes data as ~w, but in “pretty printing” mode, breaking lines in appropriate
places, indenting sensibly, and outputting lists as strings where possible.
~W, ~P
Behave as ~w, ~p, but eliding structure at a depth of 3. These take an extra argument
in the data list indicating the maximum depth for printing terms.
~B
Shows an integer to base 10.

```
1> List = [2,3,math:pi()].
[2,3,3.141592653589793]
2> Sum = lists:sum(List).
8.141592653589793
3> io:format("hello, world!~n",[]).
hello, world!
ok
4> io:format("the sum of ~w is ~w.~n", [[2,3,4],ioExs:sum([2,3,4])]).
the sum of [2,3,4] is 9.
ok
5> io:format("the sum of ~w is ~w.~n", [List,Sum]).
the sum of [2,3,3.141592653589793] is 8.141592653589793.
ok
6> io:format("the sum of ~W is ~w.~n", [List,3,Sum]).
the sum of [2,3|...] is 8.141592653589793.
ok
7> io:format("the sum of ~W is ~f.~n", [List,3,Sum]).
the sum
```

### Anonymous Functions

```
13> Executor = fun(FunArg, Arg) -> FunArg(Arg) end.
#Fun<erl_eval.13.126501267>
14> MyFunc = fun(Arg) -> Arg + 1 end.
#Fun<erl_eval.7.126501267>
16> MyFunc(100).
101
17> Executor(MyFunc, 100).
101

3> (fun(Int) -> Int + 1 end)(9).
10

1> FunctionA = fun([]) -> null;
1> ([X|_]) -> X
1> end.
```