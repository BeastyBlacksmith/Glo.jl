# Glo

[![Build Status](https://travis-ci.com/beastyblacksmith/Glo.jl.svg?branch=master)](https://travis-ci.com/beastyblacksmith/Glo.jl)
[![Codecov](https://codecov.io/gh/beastyblacksmith/Glo.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/beastyblacksmith/Glo.jl)

Julia wrapper of the [Glo-board API](https://gloapi.gitkraken.com/v1/docs/#/).
Developer documentation is [here](https://support.gitkraken.com/developers/overview/).

## Authentification

In order to use this API you have to pass a header specifying your authentification.

### Authentification via personal access token (PAT)

A personal access token can be created [here](https://app.gitkraken.com/pat/new)
```julia
using Glo
# This gets you all your boards
Glo.boards(
    header = [
        "Content-Type" => "application/json",
        "Accept" => "application/json",
        "Authorization" => "Bearer <yourPAT>"
    ]
)
```
