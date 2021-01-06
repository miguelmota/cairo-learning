func main():
  call foo
  call foo
  call foo

  ret
end

func foo():
  [ap] = 1000; ap++
  ret
end
