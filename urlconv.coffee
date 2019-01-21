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
      chrome.storage.sync.get ["password1"], (item) ->
        url = location.href
        newurl = url
        unless /no_forward/.exec url
          if match = /forwarded_from_url_(.*)$/.exec url
            # location.href = decodeURIComponent(match[1]) + '#no_forward'
          else
            if match = /^(.*\/)[0-9a-f]\/[0-9a-f]\/([0-9a-f]{32})(\.\w+)?$/.exec url
              newhash = crypt(match[2],item.password1)
              match2 = /^(.)(.)/.exec newhash
              newurl = match[1] + match2[1] + '/' + match2[2] + '/' + newhash + match[3]
            else if match = /^(.*\/)(\w+)\.([^\/]*)$/.exec url
              newurl = match[1] + crypt(match[2],item.password1) + '.' + match[3]
            else if match = /^(.*\/)(\w+)$/.exec url
            newurl = match[1] + crypt(match[2],item.password1)
            location.href = newurl + '#forwarded_from_url_' # + encodeURIComponent(url)
    403: () ->
      chrome.storage.sync.get ["secret"], (item) ->
        url = location.href
        newurl = url
        unless /no_forward/.exec url
          if match = /forwarded_from_url_(.*)$/.exec url
            # location.href = decodeURIComponent(match[1]) + '#no_forward'
          else
            if match = /^(.*\/)[0-9a-f]\/[0-9a-f]\/([0-9a-f]{32})(\.\w+)?$/.exec url
              newhash = crypt(match[2],item.secret)
              match2 = /^(.)(.)/.exec newhash
              newurl = match[1] + match2[1] + '/' + match2[2] + '/' + newhash + match[3]
            else if match = /^(.*\/)(\w+)\.([^\/]*)$/.exec url
              newurl = match[1] + crypt(match[2],item.secret) + '.' + match[3]
            else if match = /^(.*\/)(\w+)$/.exec url
              newurl = match[1] + crypt(match[2],item.secret)
            location.href = newurl + '#forwarded_from_url_' # + encodeURIComponent(url)

#      chrome.storage.sync.get ["secret"], (item) ->
#        url = location.href
#        unless /forwarded_by_urlconv/.exec url
#          if match = /^(.*\/)(\w+)\.([^\/]*)$/.exec url
#            url = match[1] + crypt(match[2],item.secret) + '.' + match[3]
#          else if match = /^(.*\/)(\w+)$/.exec url
#            url = match[1] + crypt(match[2],item.secret)
#          location.href = url + '#forwarded_by_urlconv'


