func foo(x, y) -> (z, w):
  [ap] = x + y; ap++ # z
  [ap] = x * y; ap++ # w
  ret
end

func main():
  foo(x=4, y=5)
  [ap] = [ap - 1] + [ap - 2]; ap++ # compute z + w
  ret
end
