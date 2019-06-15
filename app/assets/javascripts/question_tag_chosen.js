$(document).ready(function(){
  $('.chosen-select').chosen();

  $('.chosen-choices input').autocomplete({
    source: function( request, response ) {
      var currentSearch = $('.chosen-choices input').val()
      $.ajax({
        url: "/tags.json?q="+$('.chosen-choices input').val(),
        dataType: "json",
        beforeSend: function(){$('ul.chzn-results').empty();},
        success: function( data ) {
          response( $.map( data.reverse(), function( item ) {
            $('.chosen-select').prepend($('<option></option>').val(item.name).html(item.name));
            $('.chosen-select').trigger("chosen:updated");
            $('.chosen-choices input').val(currentSearch);
          }));
        }
      });
    }
  });
});
