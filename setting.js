//var abc = document.getElementById('abc')
//alert(abc)
//abc.addEventListener('click',function(){alert(localStorage['abcde'])})
//localStorage['abcde'] = 'abcde'


$(function(){
    //var button = document.getElementById('submit')
    //alert(button)
    //button.addEventListener('click',register)


    chrome.storage.sync.get(["secret"], (item) => $('#secret').val(item.secret))

    $('#submit').on('click', ()=> {
	chrome.storage.sync.set(
	    {
		"secret": $('#secret').val()
	    }
	);
    })
})
