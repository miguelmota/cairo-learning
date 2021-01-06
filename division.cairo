%builtins output

func main(output_ptr) -> (output_ptr):
  assert [output_ptr] = 6 /3
  assert [output_ptr + 1] = 7 / 3
  assert [output_ptr + 2] = 1206167596222043737899107594365023368541035738443865566657697352045290673496 * 3

  return (output_ptr=output_ptr + 3)
end
