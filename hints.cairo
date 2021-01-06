func foo() -> (res):
    alloc_locals
    local x = 5
    assert x * x = 25
    return (res=x)
end

func bar() -> (res):
    alloc_locals
    local x

    # this is a hint.
    # it instructs prover to assign the value 5 to the variable x
    %{ ids.x = 5 %}

    assert x * x = 25
    return (res=x)
end
