#
# 登録したパタンにマッチした場合はURLを変換
#
chrome.storage.sync.get ["password1","password2","password3","address1","address2","address3"], (item) ->
  url = location.href
  newurl = null
  unless /forwarded_by_real_url/.exec url
    if item.password1 != "" && url.indexOf(item.address1) >= 0
      newurl = crypturl url, item.password1
    else if item.password2 != "" && url.indexOf(item.address2) >= 0
      newurl = crypturl url, item.password2
    else if item.password3 != "" && url.indexOf(item.address3) >= 0
      newurl = crypturl url, item.password3
    if newurl # 飛ばす可能性があるとき
      newurl += '#forwarded_by_real_url'
      $.ajax
        type: 'GET'
        statusCode:
          404: () -> location.href = newurl
          403: () -> location.href = newurl
