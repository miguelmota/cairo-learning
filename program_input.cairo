func main():
  %{
    memory[ap] = program_input['secret']
  %}
  [ap] = [ap]; ap++
  ret
end
