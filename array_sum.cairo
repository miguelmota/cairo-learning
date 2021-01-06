%builtins output

from starkware.cairo.common.alloc import alloc

# computes the sum of the memory elements at addresses:
#   arr + 0, arr + 1, ..., arr + (size - 1)
func array_sum(arr, size) -> (sum):
    if size == 0:
        return (sum=0)
    end

    # size is not zero
    let (sum_of_rest) = array_sum(arr=arr + 1, size=size - 1)
    return (sum=[arr] + sum_of_rest)
end

func main(output_ptr) -> (output_ptr):
    const ARRAY_SIZE = 3

    # allocate an array
    let (ptr) = alloc()

    # populate some values in the array
    assert [ptr] = 9
    assert [ptr + 1] = 16
    assert [ptr + 2] = 25

    # call array_sum to compute the sum of the elements
    let (sum) = array_sum(arr=ptr, size=ARRAY_SIZE)

    # write the sum to the program output
    assert [output_ptr] = sum

    # return the new output pointer, which points to the end of the program output
    return (output_ptr=output_ptr + 1)
end
