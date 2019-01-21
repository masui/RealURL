
$(function(){
    chrome.storage.sync.get(["secret"], (item) => $('#secret').val(item.secret))

    $('#register').on('click', ()=> {
	chrome.storage.sync.set(
	    {
		"password1": $('#password1').val(),
		"password2": $('#password2').val()
	    }
	);
    })
})
