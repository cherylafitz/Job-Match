$(function(){
    $('[data-toggle="tooltip"]').tooltip()

  // ajax delete
  $('.js-delete-btn').on('click',function(e){
    e.preventDefault();
    var btn=$(this);
    $.ajax({
      url:  btn.attr('href'),
      method:'DELETE',
      dataType:'json'
    }).done(function(data){
      if(data){
        btn.closest('.cloud-container').remove();
      }
    })
});

      $('#myModal').on('hidden.bs.modal', function() {
      $(this).removeData('bs.modal');
  });

  // if(typeof gon != 'undefined'){
  //     console.log('taco is', gon.taco);
  // }else{
  //     console.log('there is no gon (or taco)');
  // }
    removeOverflowing = true;

    var word_array = gon.job_desc
    console.log(word_array)
    if (word_array) {
    var i = 0;
      $('.clouds').find('.job-desc').each(function(child) {
        console.log(i)
        $(this).jQCloud(word_array[i], {
          shape: 'rectangular',
            classPattern: null,
  colors: ["#800026", "#bd0026", "#e31a1c", "#fc4e2a", "#fd8d3c", "#feb24c", "#fed976", "#ffeda0", "#ffffcc"],
  fontSize: {
    from: 0.1,
    to: 0.02
  }
        });

        console.log("this is time " + i)
        i += 1;
      });
      if ($('.clouds').parent().hasClass('main')) {
      $('.clouds').find('.job-desc').last().closest('div.col-md-6').addClass('last-cloud col-md-offset-3 col-lg-offset-3')
      }
   }
  // }
    // console.log(arr + i)
  // var resume_cloud = function(){
    if (gon.resume) {
    word_array = gon.resume
    console.log(word_array)
    $('.resume').jQCloud(word_array, {
      shape: 'rectangular',
      autoResize: true,
      fontSize: {
        from: 0.1,
        to: 0.02
      }
    });
  }
  // console.log(arr1)
  // $('.job-desc').jQCloud(arr1)
  // console.log($('.job-desc').text())
  // console.log(gon.word_arr)
// alert('hey');
  // }
  // resume_cloud();
  // job_clouds();
});