//var abc = document.getElementById('abc')
//alert(abc)
//abc.addEventListener('click',function(){alert(localStorage['abcde'])})
//localStorage['abcde'] = 'abcde'


function register(){
    alert("register")
//    chrome.storage.sync.set(
//	{
//	    "secret": "SECRET_STRING"
//	}
//    );
}

// md5 = typeof require == 'undefined' ?  exports : require('./md5.js')

$(function(){
    //var button = document.getElementById('submit')
    //alert(button)
    //button.addEventListener('click',register)
    $('#submit').on('click', ()=> {
	//alert(MD5_hexhash("aaaa"))
	chrome.storage.sync.set(
	    {
		"secret": $('#secret').val()
	    }
	);
    })
})
