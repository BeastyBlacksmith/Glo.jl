@eval $(declare_api("https://gloapi.gitkraken.com/v1/glo", "GET", "/boards", ["fields", "archived", "page", "per_page", "sort"]))
@eval $(declare_api("https://gloapi.gitkraken.com/v1/glo", "POST", "/boards", []))
@eval $(declare_api("https://gloapi.gitkraken.com/v1/glo", "GET", "/boards/{board_id}", []))
