$(function(){
  // console.log(gon.results)
    var word_array = gon.job_desc
  // for (i=0; i<3;i++) {
    var i = 0;
    $('.clouds').find('.job-desc').each(function(child) {
      console.log(i)
      // console.log(this);
      $(this).jQCloud(word_array[i]);
      console.log("this is time " + i)
      i += 1;
    });
    $('.clouds').find('.job-desc').last().closest('div.col-md-6').addClass('last-cloud col-md-offset-3 col-lg-offset-3')
    // console.log(arr + i)

  // console.log(arr1)
  // $('.job-desc').jQCloud(arr1)
  // console.log($('.job-desc').text())
  // console.log(gon.word_arr)
// alert('hey');
});