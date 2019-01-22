#
# crypt.coffee - EpisoPassでの文字置換
#
# Toshiyuki Masui @ Pitecan.com
# Last Modified: 2015/10/31 12:20:30
#

# md5 = if typeof require == 'undefined' then exports else require('./md5.js')

#  文字種ごとに置換を行なうためのテーブル
charset = [
  'abcdefghijklmnopqrstuvwxyz'
  'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
  '0123456789'
  '-'
  '~!@#$%^&*()_=+[{]}|;:.,#?'
  ' '
  "\"'/<>\\`"
]

charkind = (c) ->
  ind = null
  [0...charset.length].forEach (i) ->
    ind = i if charset[i].indexOf(c) >= 0
  ind
    
# crypt_char(crypt_char(c,n),n) == c になるような文字置換関数
crypt_char = (c, n) ->
  kind = charkind(c)
  chars = charset[kind]
  cind = chars.indexOf(c)
  len = chars.length
  ind = (n - cind + len) % len
  chars[ind]

#
# UTF8文字列をバイト文字列(?)に変換
# (MD5_hexhashがUTF8データをうまく扱えないため)
#
utf2bytestr = (text) ->
  result = ""
  return result if text == null
  [0...text.length].forEach (i) ->
    c = text.charCodeAt(i)
    if c <= 0x7f
      result += String.fromCharCode(c)
    else
      if c <= 0x07ff
        result += String.fromCharCode(((c >> 6) & 0x1F) | 0xC0)
        result += String.fromCharCode((c & 0x3F) | 0x80)
      else
        result += String.fromCharCode(((c >> 12) & 0x0F) | 0xE0)
        result += String.fromCharCode(((c >> 6) & 0x3F) | 0x80)
        result += String.fromCharCode((c & 0x3F) | 0x80)
  result

#
# crypt(crypt(s,data),data) == s になる
#
crypt = (str,data) ->
  # seeddataのMD5の32バイト値の一部を取り出して数値化し、
  # その値にもとづいて文字置換を行なう
  #
  # hash = data

  hash = data
  unless /^[a-fA-F0-9]{32}$/.test hash
    hash = MD5_hexhash utf2bytestr(data)

  if /^[a-f0-9]{32}$/.test str
    charset = [ 'abcdef0123456789' ]
  if /^[A-F0-9]{32}$/.test str
    charset = [ 'ABCDEF0123456789' ]

  res = ''
  [0...str.length].forEach (i) ->
    j = i % 8
    s = hash.substring(j*4,j*4+4)
    n = parseInt(s,16)
    res += crypt_char(str[i],n+i)
  res

crypturl = (url,password) ->
  newurl = url
  if match = /^(.*\/)[0-9a-f]\/[0-9a-f]\/([0-9a-f]{32})(\.\w+)?$/.exec url
    newhash = crypt match[2], password
    match2 = /^(.)(.)/.exec newhash
    newurl = match[1] + match2[1] + '/' + match2[2] + '/' + newhash + match[3]
  else if match = /^(.*\/)(\w+)\.([^\/]*)$/.exec url
    newurl = match[1] + crypt(match[2],password) + '.' + match[3]
  else if match = /^(.*\/)(\w+)$/.exec url
    newurl = match[1] + crypt(match[2],password)
  newurl
