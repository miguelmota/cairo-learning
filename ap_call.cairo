func foo(x, y) -> (z, w):
  [ap] = x + y; ap++ # z
  [ap] = x * y; ap++ # w
  ret
end

func main():
  # arguments are written to the 'stack' before 'call' instruction
  [ap] = 4; ap++
  [ap] = 5; ap++
  call foo # foo(4, 5)
  ret
end
