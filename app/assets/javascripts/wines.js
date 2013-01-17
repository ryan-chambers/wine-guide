function enableGrapePicker() {
    var $grape_select = $('#grape_0');
    var $selected_grape_ids = $('#grapes_grapes');
    var $grape_list = $('#grape_list');
    var counter = 0;

    $grape_select.change(function() {
        var $selected = $('#grape_0 option:selected');
        var grape_id = $selected.attr('value');
        var grape_name = $selected.text();

        $selected_grape_ids.val($selected_grape_ids.val() + '|' + grape_id);
        $grape_list.append('<li class=grape_ctr_' + counter + '>' + grape_name + '&nbsp;<a href="#" class="remove_grape">Remove</a></li>');
        counter++;
    });

    $(document).on('click', '.remove_grape', function(e) {
        var class_to_remove = $(e.currentTarget).parent().attr('class');
        $('.' + class_to_remove).remove();
    });
}
