func foo1() -> (a, b):
  return (4, 5)
end

# same as above
func foo2() -> (a, b):
  return (a=4, b=5)
end

# same as above
func foo3() -> (a, b):
  [ap] = 4; ap++
  [ap] = 5; ap++
  ret
end

# same as above
func foo4() -> (a, b):
  [ap] = 4; ap++
  [ap] = 5; ap++
  return ([ap - 2], [ap - 1])
end

# same as above
func foo5() -> (a, b):
  [ap] = 4; ap++
  [ap] = 5; ap++
  return (...)
end

func main():
  foo5()
  return ()
end
