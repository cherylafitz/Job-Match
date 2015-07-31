$(function(){
  // tooltip
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
  // modal
  $('#myModal').on('hidden.bs.modal', function() {
    $(this).removeData('bs.modal');
  });
  // active class for nav
  var navLink = $('.nav.navbar-nav li a');
  var searchLink = $('.search-link');
  var jobBoardLink = $('.job-board-link');
  var resumeLink = $('.resume-link');
  if (navLink.hasClass('active')) {

  }
  if ($('.search-page')[0]) {
    navLink.removeClass('active');
    $(searchLink).addClass('active');
  } else if ($('.job-board')[0]) {
    navLink.removeClass('active');
    $(jobBoardLink).addClass('active');
  } else if ($('.resume-page')[0]) {
    $(resumeLink).addClass('active');
  }

  // cloud generation
  var word_array = gon.job_desc
  if (word_array) {
  var i = 0;
    $('.clouds').find('.job-desc').each(function(child) {
      $(this).jQCloud(word_array[i], {
        shape: 'rectangular',
        });
        i += 1;
      });
      if ($('.clouds').parent().hasClass('main')) {
      $('.clouds').find('.job-desc').last().closest('div.col-md-6').addClass('last-cloud col-md-offset-3 col-lg-offset-3')
      }
   }
  if (gon.resume) {
    word_array = gon.resume
    $('.resume').jQCloud(word_array, {
      shape: 'rectangular',
      autoResize: true,
      fontSize: {
        from: 0.1,
        to: 0.02
      }
    });
  }

});