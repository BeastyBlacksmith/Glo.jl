module Glo

using MacroTools
using MacroTools: striplines
using JSON
using HTTP
# Kindly adopted form Lyndon White (https://github.com/oxinabox/RESTful.jl/blob/master/src/proto.ipynb)
# TODO: how to deal with (multiple) IDs, make dispatches for deletion
function declare_api(root, method, endpoint, param_names)
    page_params = Symbol[]
    for match in eachmatch(r"\{([A-z]+)\}", endpoint)
        push!( page_params, Symbol(match.captures[1]) )
        endpoint = join( [endpoint[1:match.offset-1], endpoint[match.offset+1+length(match.match):end]] )
    end
    @show page_params, endpoint
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

    if method == "POST"
        quote
            function $(function_name)($(param_sig),post_msg)
                query = Dict()
                $(set_query_code)
                uri = HTTP.URI($root)
                uri = merge(uri; path=uri.path*$endpoint, query=query)
                resp = HTTP.request($method, uri, header, post_msg)
                JSON.parse(String(resp.body))
            end
        end|> MacroTools.unblock
    else
        quote
            function $(function_name)($(param_sig))
                query = Dict()
                $(set_query_code)
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
