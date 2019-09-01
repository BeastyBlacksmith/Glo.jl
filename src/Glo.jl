module Glo

using MacroTools
using MacroTools: striplines
using JSON
using HTTP
# Kindly adopted form Lyndon White (https://github.com/oxinabox/RESTful.jl/blob/master/src/proto.ipynb)
function declare_api(root, method, endpoint, param_names)
    function_name = Symbol(join(split(endpoint, "/"; keepempty=false), "_"))
    param_sig = Expr(:parameters,Expr.(:kw, Symbol.(param_names), :nothing)...)

    set_query_code = Expr(:block)
    set_query_code.args = map(param_names) do param
        quote
             if $(Symbol(param)) != nothing
                query[$(String(param))] = $(Symbol(param))
            end
        end |> MacroTools.unblock
    end

    quote
        function $(function_name)($(param_sig))
            query = Dict()
            $(set_query_code)
            uri = HTTP.URI($root)
            uri = merge(uri; path=uri.path*$endpoint, query=query)
            resp = HTTP.request($method, uri, ["USER-AGENT"=>"RESTful.jl"])
            JSON.parse(String(resp.body))
        end
    end|> MacroTools.unblock
end

include("declarations.jl")
end # module
