#conv = () ->
#  $("a").each () ->
#    href = $(this).attr('href')
#    if href
#      if $(this).attr('href').match /masui.org/
#        $(this).attr('href','http://example.com')
#
#$ ->
#  setInterval conv, 3000

# jump = () ->
#   href = location.href
#   if href
#     if href.match /asahi.com/
#       location.href = 'http://example.com'

# alert localStorage['abcde']
# localStorage['abcde'] = 'abcde'

# $ ->

$.ajax
  type: 'GET'
  statusCode:
    404: () ->
      chrome.storage.sync.get ["secret"], (item) ->
        url = location.href
        unless /forwarded_by_urlconv/.exec url
          if match = /^(.*\/)(\w+)\.([^\/]*)$/.exec url
            url = match[1] + crypt(match[2],item.secret) + '.' + match[3]
          else if match = /^(.*\/)(\w+)$/.exec url
            url = match[1] + crypt(match[2],item.secret)
          location.href = url + '#forwarded_by_urlconv'
    403: () ->
      chrome.storage.sync.get ["secret"], (item) ->
        url = location.href
        unless /forwarded_by_urlconv/.exec url
          if match = /^(.*\/)(\w+)\.([^\/]*)$/.exec url
            url = match[1] + crypt(match[2],item.secret) + '.' + match[3]
          else if match = /^(.*\/)(\w+)$/.exec url
            url = match[1] + crypt(match[2],item.secret)
          location.href = url + '#forwarded_by_urlconv'


