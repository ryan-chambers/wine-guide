var wines = function() {
	var $modal_reference;

	function enableBottleTweeting(modal_id) {
		$modal_reference = $(modal_id);
		$modal_reference.modal({show: false});
		return $modal_reference;
	}

	function generateTweet(bottle_id, callback) {
        $.ajax({
            url: '/tweets/bottle.json?bottle_id=' + bottle_id,
            context: document.body
        }).done(callback);
	}

	return {
		enableBottleTweeting: enableBottleTweeting,
		generateTweet: generateTweet
	};
}();
