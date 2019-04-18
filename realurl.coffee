# $ ->

# backgroundFunction = () ->
#   # alert "バックグラウンドの関数を実行!"
#   alert location.href
#   $.ajax
#     type: 'GET'
#     statusCode:
#       404: () -> hop()
#       403: () -> hop()
#   
# bgWindow = chrome.extension.getBackgroundPage()
# console.log bgWindow.backgroundFunction()

hop = () ->
  chrome.storage.sync.get ["password1","password2","password3","address1","address2","address3"], (item) ->
    url = location.href
    unless /forwarded_by_real_url/.exec url
      if item.password1 != "" && url.indexOf(item.address1) >= 0
        newurl = crypturl url, item.password1
        location.href = newurl + '#forwarded_by_real_url'
      else if item.password2 != "" && url.indexOf(item.address2) >= 0
        newurl = crypturl url, item.password2
        location.href = newurl + '#forwarded_by_real_url'
      else if item.password3 != "" && url.indexOf(item.address3) >= 0
        newurl = crypturl url, item.password3
        location.href = newurl + '#forwarded_by_real_url'
    
$.ajax
  type: 'GET'
  statusCode:
    404: () -> hop()
    403: () -> hop()
