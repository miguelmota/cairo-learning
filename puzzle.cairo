%builtins output range_check

from starkware.cairo.common.registers import get_fp_and_pc
from starkware.cairo.common.dict import DictAccess
from starkware.cairo.common.dict import squash_dict
from starkware.cairo.common.alloc import alloc

struct Location:
    member row = 0
    member col = 1
    const SIZE = 2
end

func verify_valid_location(loc : Location*):
    # check that row is in the range 0-3
    tempvar row = loc.row
    assert row * (row - 1) * (row - 2) * (row - 3) = 0

    # check that col is in the range 0-3
    # one of the values must be 0 to get 0
    tempvar col = loc.col
    assert col * (col - 1) * (col - 2) * (col - 3) = 0

    return ()
end

func verify_adjacent_locations(loc0 : Location*, loc1 : Location*):
    alloc_locals
    local row_diff = loc0.row - loc1.row
    local col_diff = loc0.col - loc1.col

    if row_diff == 0:
        # the row coordinate is the same. Make sure the difference in col is 1 or -1
        assert col_diff * col_diff = 1
        return ()
    else:
        # verify the difference in row is 1 or -1
        assert row_diff * row_diff = 1
        # verify that the col coordinate is the same
        assert col_diff = 0
        return ()
    end
end

func verify_location_list(loc_list : Location*, n_steps):
    # always verify that the location is valid, even if
    # n_steps = 0 (remember that there is always one more location than steps)
    verify_valid_location(loc=loc_list)

    if n_steps == 0:
        return ()
    end

    verify_adjacent_locations(loc0=loc_list, loc1=loc_list + Location.SIZE)

    # call verify_location_list recursively
    verify_location_list(loc_list=loc_list + Location.SIZE, n_steps=n_steps - 1)
    return ()
end

func build_dict(loc_list : Location*, tile_list : felt*, n_steps, dict : DictAccess*) -> (
        dict : DictAccess*):
    if n_steps == 0:
        # when there are no more steps, just return the dict pointer
        return (dict=dict)
    end

    # set the key to the current title being moved
    assert dict.key = [tile_list]

    # it's previous location should be where the empty tile is
    # going to be
    let next_loc : Location* = loc_list + Location.SIZE
    assert dict.prev_value = 4 * next_loc.row + next_loc.col

    # it's next location should be where the empty tile is no
    assert dict.new_value = 4 * loc_list.row + loc_list.col

    # call build_dict recursively
    build_dict(
        loc_list=next_loc,
        tile_list=tile_list + 1,
        n_steps=n_steps - 1,
        dict=dict + DictAccess.SIZE)
    return (...)
end

func finalize_state(dict : DictAccess*, idx) -> (dict : DictAccess*):
    if idx == 0:
        return (dict=dict)
    end

    assert dict.key = idx
    assert dict.prev_value = idx - 1
    assert dict.new_value = idx - 1

    # call finalize_state recursively
    finalize_state(dict=dict + DictAccess.SIZE, idx=idx - 1)
    return (...)
end

func output_initial_values(output_ptr : felt*, squashed_dict : DictAccess*, n) -> (
        output_ptr : felt*):
    if n == 0:
        return (output_ptr=output_ptr)
    end

    assert [output_ptr] = squashed_dict.prev_value
    # call output_initial_values recursively
    output_initial_values(output_ptr=output_ptr + 1, squashed_dict=squashed_dict + DictAccess.SIZE, n=n-1)
    return (...)
end

func check_solution(
        output_ptr : felt*, range_check_ptr, loc_list : Location*, tile_list : felt*, n_steps) -> (
        output_ptr : felt*, range_check_ptr):
    alloc_locals
    # start by verifying that loc_list is valid
    verify_location_list(loc_list=loc_list, n_steps=n_steps)

    # allocate memory for the dict and the squashed dict
    let (dict_start : DictAccess*) = alloc()
    local dict_start : DictAccess* = dict_start
    let (squashed_dict : DictAccess*) = alloc()
    local squashed_dict : DictAccess* = squashed_dict

    let (dict_end) = build_dict(
        loc_list=loc_list, tile_list=tile_list, n_steps=n_steps, dict=dict_start)
    let (dict_end) = finalize_state(dict=dict_end, idx=15)

    # store range_check_ptr in a local variable to make it
    # accessible after the call to output_initial_values(
    let (local range_check_ptr, squashed_dict_end : DictAccess*) = squash_dict(
        range_check_ptr=range_check_ptr,
        dict_accesses=dict_start,
        dict_accesses_end=dict_end,
        squashed_dict=squashed_dict)

    # verify that the squashed dict has exactly 15 entries.
    # this will gurantee that all the value sin the tile list
    # are in the range 1-15
    assert squashed_dict_end - squashed_dict = 15 * DictAccess.SIZE
    let (output_ptr) = output_initial_values(
        output_ptr=output_ptr, squashed_dict=squashed_dict, n=15)

    # output the initial location of the empty tile
    assert [output_ptr] = 4 * loc_list.row + loc_list.col

    # output the number of steps
    assert [output_ptr + 1] = n_steps

    return (output_ptr=output_ptr + 2, range_check_ptr=range_check_ptr)
end

func main(output_ptr : felt*, range_check_ptr) -> (output_ptr : felt*, range_check_ptr):
    alloc_locals

    # declare two variables that will point to the two lists and
    # another variable that will contain the number of steps.
    local loc_list: Location*
    local tile_list: felt*
    local n_steps

    %{
      # the verifier doesn't care where those list are
      # allocated or what values they contain, so we use a hint
      # to populate them.
      locations = program_input['loc_list']
      tiles = program_input['tile_list']

      ids.loc_list = loc_list = segments.add()
      for i, val in enumerate(locations):
        memory[loc_list + i] = val

      ids.tile_list = tile_list = segments.add()
      for i, val in enumerate(tiles):
          memory[tile_list + i] = val

      ids.n_steps = len(tiles)

      # sanity check (only the provder runs this check)
      assert len(locations) == 2 * (len(tiles) + 1)
    %}

    # Get the value of the frame pointer register (fp) so that
    # we can use the address of loc0
    let (__fp__, _) = get_fp_and_pc()
    let (output_ptr, range_check_ptr) = check_solution(
        output_ptr=output_ptr,
        range_check_ptr=range_check_ptr,
        loc_list=loc_list,
        tile_list=tile_list,
        n_steps=n_steps)
    return (output_ptr=output_ptr, range_check_ptr=range_check_ptr)
end
