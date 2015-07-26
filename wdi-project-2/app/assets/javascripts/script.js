$(function(){
  // console.log(gon.results)

  // for (i=0; i<3;i++) {
    var i = 0;
    $('.clouds').children('.job-desc').each(function(child) {
      i += 1;
      // console.log(this);
      $(this).jQCloud(gon.job_desc[i]);
    });
    // console.log(arr + i)

  // console.log(arr1)
  // $('.job-desc').jQCloud(arr1)
  // console.log($('.job-desc').text())
  // console.log(gon.word_arr)
// alert('hey');
});