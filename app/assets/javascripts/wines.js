var wines = function() {

	function enableGrapePicker() {
	    var $grape_select = $('#grape_0');
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
	        var grape_name = $grape_select.find('option[value="' + grape_id + '"]').text();
	        if(grape_name !== '') {
	            addGrapeToList(grape_id, grape_name);
	        }
	    });
	
	    $grape_select.change(function() {
	        var $selected = $('#grape_0 option:selected');
	        var grape_id = $selected.attr('value');
	        var grape_name = $selected.text();
	
	        $selected_grape_ids.val($selected_grape_ids.val() + '|' + grape_id);
	        addGrapeToList(grape_id, grape_name);
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
	
	return {
		enableGrapePicker: enableGrapePicker,
		enableRegionPicker: enableRegionPicker
	}	
}();
