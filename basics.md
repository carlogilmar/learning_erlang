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


