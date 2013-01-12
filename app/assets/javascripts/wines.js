function enableGrapePicker() {
    var $grape_select = $('#grape_0');
    var $selected_grape_ids = $('#grapes_grapes');
    $grape_select.change(function() {
        var grape_id = $('option:selected').attr('value');

        $selected_grape_ids.val($selected_grape_ids.val() + '|' + grape_id);
    });
}
