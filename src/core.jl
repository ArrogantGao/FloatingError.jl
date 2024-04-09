abstract type AbstractEFloat <: AbstractFloat end

struct EFloat{T} <: AbstractEFloat
    n::T
    ϵ::T
end

EFloat(n::T) where{T <: AbstractFloat} = EFloat{T}(n, eps(n))

Base.show(io::IO, x::EFloat) = print(io, x.n, " ± ", x.ϵ)
Base.:+(x::EFloat{T}, y::EFloat{T}) where{T} = EFloat(x.n + y.n, eps(abs(x.n + y.n) + x.ϵ + y.ϵ) + x.ϵ + y.ϵ)
Base.:-(x::EFloat{T}, y::EFloat{T}) where{T} = EFloat(x.n - y.n, eps(abs(x.n - y.n) + x.ϵ + y.ϵ) + abs(x.ϵ - y.ϵ))
Base.:*(x::EFloat{T}, y::EFloat{T}) where{T} = EFloat(x.n * y.n, T(sqrt(5)) * eps((abs(x.n) + x.ϵ) * (abs(y.n) + y.ϵ)) + abs(x.n * y.ϵ) + abs(y.n * x.ϵ))