var wines = function() {
	var $modal_reference;

	function enableGrapePicker(grape_name_field) {
	    var $grape_name = grape_name_field;
	    var $selected_grape_ids = $('#grape_ids');
	    var $grape_list = $('#grape_list');
	    var counter = 0;

	    function addGrapeToList(grape_id, grape_name) {
	        $grape_list.append('<li class="grape_ctr_' + counter + '" data-id="' + grape_id + '">' + grape_name + '&nbsp;<a href="#" class="remove_grape">Remove</a></li>');
	        counter++;
	    }

	    // create grape list if grape_ids already populated
	    $selected_grape_ids.val().split('|').forEach(function (grape_id) {
	        grape_id = $.trim(grape_id);
	        if(grape_id === '') {
	            return;
	        }
	        var grape_name = $grape_name.find('option[value="' + grape_id + '"]').text();
	        if(grape_name !== '') {
	            addGrapeToList(grape_id, grape_name);
	        }
	    });

	    $grape_name.on('typeahead:selected', function(e, selected_grape) {
	        $selected_grape_ids.val($selected_grape_ids.val() + '|' + selected_grape.id);
	        // FIXME filter out duplicate grapes
	        addGrapeToList(selected_grape.id, selected_grape.name);
	        $grape_name_field.typeahead('setQuery', '');
	    });

	    $(document).on('click', '.remove_grape', function(e) {
	        var $selected = $(e.currentTarget).parent();
	        var class_to_remove = $selected.attr('class');
	        var id = $selected.data('id') + '';
	
	        $('.' + class_to_remove).remove();
	
	        var kept_ids = $selected_grape_ids.val().split('|').filter(function(item) {
	            var result = item.length > 0 && item !== id && item !== ' ';
	            return result;
	        });
	        $selected_grape_ids.val(kept_ids.join('|'));
	    });
	}

	function enableRegionPicker() {
	    var $region_select = $('#wine_region'),
	        $country_select = $('#wine_country');
	
	    $country_select.change(function(e) {
	        var country_name = $country_select.find('option:selected').text();
	        $.ajax({
	            url: '/countries.json?country=' + country_name,
	            context: document.body
	        }).done(function (regions) {
	            var select = document.getElementById('wine_region');
	            select.options.length = 0;
	            select.options.add(new Option('', ''));
	            regions.forEach(function (region) {
	               select.options.add(new Option(region, region));
	            });
	        });
	    });
	}

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
		enableGrapePicker: enableGrapePicker,
		enableRegionPicker: enableRegionPicker,
		enableBottleTweeting: enableBottleTweeting,
		generateTweet: generateTweet
	};
}();
