FILENAME=test

compile:
	cairo-compile $(FILENAME).cairo --output $(FILENAME)_compiled.json

run:
	cairo-run --program=$(FILENAME)_compiled.json --print_output --layout=small --print_info --relocate_prints --print_memory

run-puzzle:
	cairo-run --program=puzzle_compiled.json --print_output --layout=small --print_info --relocate_prints --print_memory --program_input=puzzle_input.json

run-pc:
	cairo-run --program=pc_compiled.json --print_output --layout=small --print_info --relocate_prints --print_memory --no_end --step=16

run-program-input:
	cairo-compile program_input.cairo --output program_input_compiled.json
	cairo-run --program=program_input_compiled.json --print_output --layout=small --print_info --relocate_prints --print_memory --program_input=program_input.json

compile-run: compile run
