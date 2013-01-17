function enableGrapePicker() {
    var $grape_select = $('#grape_0');
    var $selected_grape_ids = $('#grape_ids');
    var $grape_list = $('#grape_list');
    var counter = 0;

    $grape_select.change(function() {
        var $selected = $('#grape_0 option:selected');
        var grape_id = $selected.attr('value');
        var grape_name = $selected.text();

        $selected_grape_ids.val($selected_grape_ids.val() + '|' + grape_id);
        $grape_list.append('<li class="grape_ctr_' + counter + '" data-id="' + grape_id + '">' + grape_name + '&nbsp;<a href="#" class="remove_grape">Remove</a></li>');
        counter++;
    });

    $(document).on('click', '.remove_grape', function(e) {
        var $selected = $(e.currentTarget).parent();
        var class_to_remove = $selected.attr('class');
        var id = $selected.data('id');

        $('.' + class_to_remove).remove();

        var kept_ids = $selected_grape_ids.val().split('|').filter(function(item) {
            return item.length > 0 && item !== id;
        });
        $selected_grape_ids.val(kept_ids.join('|'));
    });
}
