name=test

compile:
	cairo-compile $(name).cairo --output $(name)_compiled.json

run: compile
	cairo-run --program=$(name)_compiled.json --print_output --layout=small --print_info --relocate_prints --print_memory

run-puzzle:
	cairo-compile puzzle.cairo --output puzzle_compiled.json
	cairo-run --program=puzzle_compiled.json --print_output --layout=small --print_info --relocate_prints --print_memory --program_input=puzzle_input.json

run-pc:
	cairo-compile pc.cairo --output pc_compiled.json
	cairo-run --program=pc_compiled.json --print_output --layout=small --print_info --relocate_prints --print_memory --no_end --step=16

run-program-input:
	cairo-compile program_input.cairo --output program_input_compiled.json
	cairo-run --program=program_input_compiled.json --print_output --layout=small --print_info --relocate_prints --print_memory --program_input=program_input.json
