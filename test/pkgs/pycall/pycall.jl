module test_pkgs_pycall

using Test
using PyCall

numpy = pyimport("numpy")
@test numpy.math.__name__ == "math"
@test repr(pytypeof(numpy.math)) == "PyObject <class 'module'>"

sys = pyimport("sys")
pushfirst!(sys."path", @__DIR__)

ex = pyimport("ex")
@test ex.f() == 42

end # module test_pkgs_pycall
