
$(function(){
    chrome.storage.sync.get(["password1", "password2", "address1", "address2"], (item) => {
	$('#password1').val(item.password1);
	$('#password2').val(item.password2);
	$('#address1').val(item.address1);
	$('#address2').val(item.address2);
    });

    $('#register').on('click', () => {
	chrome.storage.sync.set(
	    {
		"password1": $('#password1').val(),
		"password2": $('#password2').val(),
		"address1": $('#address1').val(),
		"address2": $('#address2').val()
	    }
	);
    });

    $('#check').on('click', () => {
        chrome.storage.sync.get(["password1"], (item) => {
	    checkurl = $('#checkurl').val();
	    $('#checkurl').val(crypturl(checkurl,item.password1));
	});
    });
});
