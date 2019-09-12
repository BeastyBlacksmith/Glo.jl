# Glo

[![Build Status](https://travis-ci.com/beastyblacksmith/Glo.jl.svg?branch=master)](https://travis-ci.com/beastyblacksmith/Glo.jl)
[![Codecov](https://codecov.io/gh/beastyblacksmith/Glo.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/beastyblacksmith/Glo.jl)

Julia wrapper of the [Glo-board API](https://gloapi.gitkraken.com/v1/docs/#/).
Developer documentation is [here](https://support.gitkraken.com/developers/overview/).

Endpoints become functions, if IDs are involved you have to wrap them in the corresponding ID type and pass them to the function.
POST methods take the post message as first argument, and DELETE methods take ! as first argument.
No names are exportet.

## Authentification

In order to use this API you have to pass a header specifying your authentification.

### Authentification via personal access token (PAT)

A personal access token can be created [here](https://app.gitkraken.com/pat/new)

### Example usage
```julia
using Glo
example_header =  [
        "Content-Type" => "application/json",
        "Accept" => "application/json",
        "Authorization" => "Bearer <yourPAT>"
    ]
# This gets you all your boards
Glo.boards( header = example_header )
# This sets the name of the specified card to "example_card"
Glo.boards_cards( "name" => "example_card", Glo.BoardID("8581928"), Glo.CardID("0b89d129"), header = example_header) 
 # This deletes that card
Glo.boards_cards(!,  Glo.BoardID("8581928"), Glo.CardID("0b89d129"))
```
