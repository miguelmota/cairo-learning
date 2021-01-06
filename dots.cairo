func bar() -> (x):
  return (x=4)
end

func foo(x, y) -> (z, w):
  [ap] = x + y; ap++ # z
  [ap] = x * y; ap++ # w
  ret
end

func main():
  # calling 'bar' will place the value of x on the stack
  bar()

  # therefore we just need to push y and call 'foo
  foo(..., y=5)
  ret
end
