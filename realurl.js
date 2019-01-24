// Generated by CoffeeScript 2.3.2
// $ ->
var hop;

hop = function() {
  return chrome.storage.sync.get(["password1", "password2", "password3", "address1", "address2", "address3"], function(item) {
    var newurl, url;
    url = location.href;
    if (!/forwarded_by_real_url/.exec(url)) {
      if (item.password1 !== "" && url.indexOf(item.address1) >= 0) {
        newurl = crypturl(url, item.password1);
        return location.href = newurl + '#forwarded_by_real_url';
      } else if (item.password2 !== "" && url.indexOf(item.address2) >= 0) {
        newurl = crypturl(url, item.password2);
        return location.href = newurl + '#forwarded_by_real_url';
      } else if (item.password3 !== "" && url.indexOf(item.address3) >= 0) {
        newurl = crypturl(url, item.password3);
        return location.href = newurl + '#forwarded_by_real_url';
      }
    }
  });
};

$.ajax({
  type: 'GET',
  statusCode: {
    404: function() {
      return hop();
    },
    403: function() {
      return hop();
    }
  }
});