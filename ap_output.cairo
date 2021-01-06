%builtins output

func main(output_ptr) -> (output_ptr):
  [ap] = 100
  [ap] = [output_ptr]; ap++

  [ap] = 200
  [ap] = [output_ptr + 1]; ap++

  [ap] = 300
  [ap] = [output_ptr + 2]; ap++

  # return the new value of output_ptr, which was advanced by 3
  [ap] = output_ptr + 3; ap++
  ret
end
