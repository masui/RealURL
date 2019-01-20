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

# $ ->
$.ajax
  url: document.url
  type: 'GET'
  statusCode:
    404: () -> 
      location.href = 'https://gyazo.com/cb556cf419add01268e01b88905663b0.jpg'

# if location.href && location.href.match /facebook.com/i
#   location.href = 'https://gyazo.com/cb556cf419add01268e01b88905663b0.jpg'


