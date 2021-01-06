func foo(x, y) -> (z, w):
  [ap] = x + y; ap++ # z
  [ap] = x * y; ap++ # w
  ret
end

func main():
  let args = cast(ap, foo.Args*)
  args.x = 4; ap++
  args.y = 5; ap++

  # check that ap was advanced the correct number of times
  # (this will ensure arguments were not forgotten)
  static_assert args + foo.Args.SIZE == ap
  let foo_ret = call foo
  ret
end
