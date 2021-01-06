func foo(x, y) -> (z, w):
  [ap] = x + y; ap++ # z
  [ap] = x * y; ap++ # w
  ret
end

func main():
  alloc_locals
  let (local z, local w) = foo(x=4, y=5)
  [ap] = z + w; ap++
  ret
end
