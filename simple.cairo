%builtins output

func main(output_ptr) -> (output_ptr):
  assert [output_ptr] = 1234
  assert [output_ptr + 1] = 4321

  return (output_ptr=output_ptr + 2)
end
