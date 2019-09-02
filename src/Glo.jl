module Glo

using MacroTools
using MacroTools: striplines
using JSON
using HTTP
# Kindly adopted form Lyndon White (https://github.com/oxinabox/RESTful.jl/blob/master/src/proto.ipynb)
function declare_api(root, method, endpoint, param_names)
    page_paraval = Symbol[]
    page_params = Expr[]
    for match in eachmatch(r"\{([A-z]+)\}", endpoint)
        cap = match.captures[1]
        cap_type = join((x->[uppercasefirst(x[1]),uppercase(x[2])])(split(cap,"_")))
        push!( page_paraval, Symbol(cap[1:end-3]) )
        push!( page_params, Expr(Symbol("::"),Symbol(cap),Symbol(cap_type) ) )
        endpoint = join( [endpoint[1:match.offset-1], endpoint[match.offset+1+length(match.match):end]] )
    end
    function_name = Symbol(join(split(endpoint, "/"; keepempty=false), "_"))
    param_sig = Expr(:parameters, Expr(:kw, :header, String[]), Expr.(:kw, Symbol.(param_names), :nothing)...)

    set_query_code = Expr(:block)
    set_query_code.args = map(param_names) do param
        quote
            if $(Symbol(param)) != nothing
                query[$(String(param))] = $(Symbol(param))
            end
        end |> MacroTools.unblock
    end

    set_endpoint_code = Expr(:block)
    set_endpoint_code.args = map( page_paraval ) do p
        quote
            idx = findfirst(s->occursin($(String(p)),s), endpoint)
            endpoint = insert!( endpoint, idx + 1, getproperty($(Symbol(String(p)*"_id") ), :id ) )
        end |> MacroTools.unblock
    end

    if method == "POST"
        quote
            function $(function_name)($(param_sig),post_msg::String,$(page_params...))
                query = Dict()
                $(set_query_code)
                endpoint = split($endpoint,"/")
                $(set_endpoint_code)
                endpoint = join( endpoint, "/" )
                uri = HTTP.URI($root)
                uri = merge(uri; path=uri.path*$endpoint, query=query)
                resp = HTTP.request($method, uri, header, post_msg)
                JSON.parse(String(resp.body))
            end
        end|> MacroTools.unblock
    elseif method == "DELETE"
        quote
            function $(function_name)($(param_sig),::typeof(!),$(page_params...))
                query = Dict()
                $(set_query_code)
                endpoint = split($endpoint,"/")
                $(set_endpoint_code)
                endpoint = join( endpoint, "/" )
                uri = HTTP.URI($root)
                uri = merge(uri; path=uri.path*$endpoint, query=query)
                resp = HTTP.request($method, uri, header)
                JSON.parse(String(resp.body))
            end
        end|> MacroTools.unblock
    else
        quote
            function $(function_name)($(param_sig),$(page_params...))
                query = Dict()
                $(set_query_code)
                endpoint = split($endpoint,"/")
                $(set_endpoint_code)
                endpoint = join( endpoint, "/" )
                uri = HTTP.URI($root)
                uri = merge(uri; path=uri.path*$endpoint, query=query)
                resp = HTTP.request($method, uri, header)
                JSON.parse(String(resp.body))
            end
        end|> MacroTools.unblock
    end
end

include("declarations.jl")
end # module
