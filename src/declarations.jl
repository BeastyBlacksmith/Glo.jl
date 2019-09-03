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
@eval $(declare_api("https://gloapi.gitkraken.com/v1/glo", "POST", "/boards/{board_id}/columns", []))
@eval $(declare_api("https://gloapi.gitkraken.com/v1/glo", "POST", "/boards/{board_id}/columns/batch", []))
@eval $(declare_api("https://gloapi.gitkraken.com/v1/glo", "POST", "/boards/{board_id}/columns/{column_id}", []))
@eval $(declare_api("https://gloapi.gitkraken.com/v1/glo", "DELETE", "/boards/{board_id}/columns/{column_id}", []))
## Card API
@eval $(declare_api("https://gloapi.gitkraken.com/v1/glo", "GET", "/boards/{board_id}/cards", ["fields", "archived", "page", "per_page", "sort"]))
@eval $(declare_api("https://gloapi.gitkraken.com/v1/glo", "POST", "/boards/{board_id}/cards", []))
@eval $(declare_api("https://gloapi.gitkraken.com/v1/glo", "POST", "/boards/{board_id}/cards/batch", []))
@eval $(declare_api("https://gloapi.gitkraken.com/v1/glo", "GET", "/boards/{board_id}/cards/{card_id}", ["fields"]))
@eval $(declare_api("https://gloapi.gitkraken.com/v1/glo", "POST", "/boards/{board_id}/cards/{card_id}", []))
@eval $(declare_api("https://gloapi.gitkraken.com/v1/glo", "DELETE", "/boards/{board_id}/cards/{card_id}", []))
@eval $(declare_api("https://gloapi.gitkraken.com/v1/glo", "GET", "/boards/{board_id}/columns/{column_id}/cards", ["fields", "archived", "page", "per_page", "sort"]))
## Lables API
@eval $(declare_api("https://gloapi.gitkraken.com/v1/glo", "POST", "/boards/{board_id}/labels", []))
@eval $(declare_api("https://gloapi.gitkraken.com/v1/glo", "POST", "/boards/{board_id}/labels/{label_id}", []))
@eval $(declare_api("https://gloapi.gitkraken.com/v1/glo", "DELETE", "/boards/{board_id}/labels/{label_id}", []))
## Attachments API
@eval $(declare_api("https://gloapi.gitkraken.com/v1/glo", "GET", "/boards/{board_id}/cards/{card_id}/attachments", ["fields", "page", "per_page", "sort"]))
@eval $(declare_api("https://gloapi.gitkraken.com/v1/glo", "POST", "/boards/{board_id}/cards/{card_id}/attachments", []))
## Comments API
@eval $(declare_api("https://gloapi.gitkraken.com/v1/glo", "GET", "/boards/{board_id}/cards/{card_id}/comments", ["fields", "page", "per_page", "sort"]))
@eval $(declare_api("https://gloapi.gitkraken.com/v1/glo", "POST", "/boards/{board_id}/cards/{card_id}/comments", []))
@eval $(declare_api("https://gloapi.gitkraken.com/v1/glo", "POST", "/boards/{board_id}/cards/{card_id}/comments/batch", []))
@eval $(declare_api("https://gloapi.gitkraken.com/v1/glo", "POST", "/boards/{board_id}/cards/{card_id}/comments/{comment_id}", []))
@eval $(declare_api("https://gloapi.gitkraken.com/v1/glo", "DELETE", "/boards/{board_id}/cards/{card_id}/comments/{comment_id}", []))
## User API
@eval $(declare_api("https://gloapi.gitkraken.com/v1/glo", "GET", "/user", ["fields"]))
