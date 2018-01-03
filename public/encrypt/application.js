$(document).ready(function() {
    var loading = $('.loading'),
	pgp = window.openpgp,
        encrypt = function(key, message) {
	    var pubkey = pgp.key.readArmored(key);
	    return pgp.encrypt({
		data: message,
		publicKeys: pubkey.keys
	    });
	};

    $.get('/key.asc')
        .always(function() {
	    loading.hide();
	})
	.fail(function(xhr, status, errorThrown) {
	    $('#encrypted')
		.html("Couldn't get public key! Are you even on teh InterNET?!");
	})
	.done(function(key) {
	    $('#message')
		.keyup(function() {
		    var message = $('#message').val();
		    encrypt(key, message)
			.then(function(ciphertext) {
			    $('#encrypted').html(ciphertext.data);
			});
		});
	});
});
