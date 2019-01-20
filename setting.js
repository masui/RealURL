
$(function(){
    chrome.storage.sync.get(["secret"], (item) => $('#secret').val(item.secret))

    $('#submit').on('click', ()=> {
	chrome.storage.sync.set(
	    {
		"secret": $('#secret').val()
	    }
	);
    })
})
