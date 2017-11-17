$( document ).on('turbolinks:load', function() {
   $('div.dyn_sched').hide();
   $('div.dyn_sched:first').show();

   $('div.dyn_ratings').hide();
   $('div.dyn_ratings:first').show();

    $('select').change(function() {
        var val = $(this).val();
        if (val) {
            $('div.dyn_sched:not(#prof_' + val + ')').hide();
            $('#prof_' + val).show();
        } else {
            $('prof').show();
        }
    });

    $('select').change(function() {
        var val = $(this).val();
        if (val) {
            $('div.dyn_ratings:not(#prof_' + val + ')').hide();
            $('#prof_' + val).show();
        } else {
            $('prof').show();
        }
    });
});
