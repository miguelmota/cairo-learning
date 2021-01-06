func foo(x, y) -> (z, w):
  [ap] = x + y; ap++ # z
  [ap] = x * y; ap++ # w
  ret
end

func main():
  let foo_ret = foo(x=4, y=5)
  [ap] = foo_ret.z + foo_ret.w; ap++ # compute z + w
  ret
end
