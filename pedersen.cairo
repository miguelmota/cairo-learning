%builtins output pedersen


from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.hash import pedersen_hash
from starkware.cairo.common.cairo_builtins import HashBuiltin

func compute_hash(hash_ptr: HashBuiltin*, data_ptr: felt*) -> (hash_ptr: HashBuiltin*, result: felt):
  let (hash_ptr, result) = pedersen_hash(pedersen_ptr=hash_ptr, x=[data_ptr], y=[data_ptr + 1])
  return (hash_ptr=hash_ptr, result=result)
end

func main(output_ptr, pedersen_ptr: HashBuiltin*) -> (output_ptr, pedersen_ptr: HashBuiltin*):
  alloc_locals
  let (local data_ptr: felt*) = alloc()
  assert [data_ptr] = 314
  assert [data_ptr + 1] = 159

  let (pedersen_ptr, result) = compute_hash(hash_ptr=pedersen_ptr, data_ptr=data_ptr)
  assert [output_ptr] = result
  return (output_ptr + 1, pedersen_ptr)
end
