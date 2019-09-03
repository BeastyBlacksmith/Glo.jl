for id_typ in (:BoardID, :ColumnID, :CardID, :LabelID, :CommentID)
    @eval $(
        quote
            struct $id_typ
                id::String
            end
        end
    )
end
## Board API
@eval $(declare_api("https://gloapi.gitkraken.com/v1/glo", "GET", "/boards", ["fields", "archived", "page", "per_page", "sort"]))
@eval $(declare_api("https://gloapi.gitkraken.com/v1/glo", "POST", "/boards", []))
@eval $(declare_api("https://gloapi.gitkraken.com/v1/glo", "GET", "/boards/{board_id}", ["fields"]))
@eval $(declare_api("https://gloapi.gitkraken.com/v1/glo", "POST", "/boards/{board_id}", []))
@eval $(declare_api("https://gloapi.gitkraken.com/v1/glo", "DELETE", "/boards/{board_id}", []))
## Column API
## Card API
## User API
