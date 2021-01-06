func foo(x, y) -> (z, w):
  [ap] = x + y; ap++ # z
  [ap] = x * y; ap++ # w
  ret
end

func main():
  foo(2, 5)
  ret
end
