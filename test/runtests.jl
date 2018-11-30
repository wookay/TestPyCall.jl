using Test # @testset

all_tests = []
for (root, dirs, files) in walkdir(".")
    for filename in files
        !endswith(filename, ".jl") && continue
        "runtests.jl" == filename && continue
        filepath = joinpath(root, filename)[3:end]
        !isempty(ARGS) && !any(x->startswith(filepath, x), ARGS) && continue
        push!(all_tests, filepath)
    end
end

for (idx, filepath) in enumerate(all_tests)
    numbering = string(idx, /, length(all_tests))
    ts = @testset "$numbering $filepath" begin
        include(filepath)
    end
end

using Jive # Jive.Skipped
!isempty(Jive.Skipped.modules) && printstyled("skipped tests: ", join(Jive.Skipped.modules, ", "), "\n", color=:yellow)