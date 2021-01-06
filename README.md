# Cairo Learning

> Learning notes on [Cairo lang](https://www.cairo-lang.org/)

## Environment

Setting up python environment:

```bash
python -m venv ~/cairo_venv
source ~/cairo_venv/bin/activate
```

Compiling:

```bash
cairo-compile app.cairo --output app_compiled.json
```

Running:

```bash
cairo-run \
  --program=app_compiled.json --print_output \
  --print_info --relocate_prints --print_memory
```

## Notes

- parentheses in return statements are required
- return statement is required to return values
- must always have return statement even if no return values
- function return statements need to be in parentheses and indicate how many values are returned
- cannot call functions are part of expressions (i.e. `foo(bar()`) will not work)
- cannot call functions in a loop
- cairo memory is immutable
- if values were previously set then `assert` statement is invoked, otherwise it sets the value
- the deference operator is `[arr]` (in brackets), it returns the value at memory address `arr`
- the `output` builtin passes beginning of memory segment to `main`
-  convention is to return the next output cell to last one of output cell, e.g. `output_ptr + 2` if `output_ptr + 1` set
- by default variables are type field element `felt`
- a field element is integer in range _P/2 < x < P/2_ where _P_ is a very large (prime) number (252-bit number) with 76 decimal digits.
- const `SIZE` has special meaning in some cases
- there is no `<` operator (use builtins)
- use `assert_nn_le(x, y)` to check _0 <= x <= y_
- use `alloc_locals` as first statement is function to allow local variables throughout function
- use `local` to declare local variables and set `alloc_locals` at top of function
- use `tempvar` to allocate one memory cell for immediate use
- use `let` to define a reference; the expression is an alias and is not executed `let x = y * y` will not be invoked unlike `tempvar x = y * y` which stores the result)
- `ap` allocation pointer - points to an unused memory cell
- `fp'`frame pointer - points to frame of the current function.
- `pc` program counter - points to the current instruction
- `%[ <pythone-code> %]` evaluates python code, e.g. `const value = %[ 2 * 3 %] + 100`
- `...` will cancel the arguments check and use args from stack instead, i.e. `bar(); foo(..., y=5)` where _bar -> x=4_
- a _hint_ is a block of python code that will be executed by provder before the next instruction
- hints are visible to the prover
- access secret inputs in hint with `program_input['secret']`
- a _segment_ is a continuous chunk of memory
- cairo programs are kept in memory called the _program segment_
- the `pc` program counter starts at the beginning of program segment
- cairo programs have an _execution segment_ where registers `ap'` and `fp` start
- memory cells; e.g. `arr` points to first memory cell of array, `arr + 1` points to second memory cell, and so on

## License

[MIT](LICENSE)
