
$(function(){
    chrome.storage.sync.get(["password1", "password2", "password3", "address1", "address2", "address3"], (item) => {
	$('#password1').val(item.password1);
	$('#password2').val(item.password2);
	$('#password3').val(item.password3);
	$('#address1').val(item.address1);
	$('#address2').val(item.address2);
	$('#address3').val(item.address3);
    });

    $('#register').on('click', () => {
	chrome.storage.sync.set(
	    {
		"password1": $('#password1').val(),
		"password2": $('#password2').val(),
		"password3": $('#password3').val(),
		"address1": $('#address1').val(),
		"address2": $('#address2').val(),
		"address3": $('#address3').val()
	    }
	);
    });

    $('#check').on('click', () => {
	chrome.storage.sync.get(["password1", "password2", "password3", "address1", "address2", "address3"], (item) => {
	    url = $('#checkurl').val();
	    newurl = url
	    if (item.password1 !== "" && url.indexOf(item.address1) >= 0) {
		newurl = crypturl(url, item.password1);
	    } else if (item.password2 !== "" && url.indexOf(item.address2) >= 0) {
		newurl = crypturl(url, item.password2);
	    } else if (item.password3 !== "" && url.indexOf(item.address3) >= 0) {
		newurl = crypturl(url, item.password3);
	    }
	    $('#checkurl').val(newurl)
	});
    });
});
