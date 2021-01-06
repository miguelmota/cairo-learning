func main():
  # Call fib(1, 1, 10
  [ap] = 1; ap++
  [ap] = 1; ap++
  [ap] = 10; ap++
  call fib

  # make sure the 10th fibonacci number is 144
  [ap - 1] = 144
  ret
end

func fib(first_element, second_element, n) -> (res):
  jmp fib_body if n != 0
  [ap] = second_element; ap++
  ret

  fib_body:
  [ap] = second_element; ap++
  [ap] = first_element + second_element; ap++
  [ap] = n - 1; ap++
  call fib
  ret
end
