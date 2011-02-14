$(function(){
  $("#projects").change(function(){
    $("#spinner").show();
    $("#stories").html("");

    $.getJSON('stories/' + $(this).val(), function(data) {
      var stories = [];

      if(data.stories.length > 0) {
        $.each(data.stories, function(key, val) {
          var color = ((key + 1) > data.wip_limit) ? "red" : "white";
          stories.push('<li class="'+ color +'">' + val + '</li>');
        });
      } else {
        stories.push("<li>No started stories</li>");
      }

      $('<ul/>', {
        'class': 'my-new-list',
        html: stories.join('')
      }).appendTo('#stories');

      $("#spinner").hide();
    });
  });
});

