$(function(){
    $(function () {
    $('[data-toggle="tooltip"]').tooltip()
    })
  // console.log(gon.results)
  // var job_clouds = function(){
    removeOverflowing = true;
    var word_array = gon.job_desc
    console.log(word_array)
    if (word_array) {
    var i = 0;
      $('.clouds').find('.job-desc').each(function(child) {
        console.log(i)
        $(this).jQCloud(word_array[i], {
          // shape: 'rectangular',
          autoResize: true

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
      // shape: 'rectangular',
      autoResize: true
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