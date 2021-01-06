func main():
  [ap] = 25; ap++
  %{
    memory[ap] = fsqrt(memory[ap - 1])
  %}
  [ap - 1] = [ap] * [ap]; ap++
  ret
end
