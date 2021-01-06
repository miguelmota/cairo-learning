func main():
  [ap] = 2; ap++

  my_loop:
  [ap] = [ap - 1] * [ap - 1]; ap++
  [ap] = [ap - 1] + 1; ap++
  jmp my_loop
end
