$('.slide-corrida').owlCarousel({
  loop: true,
  margin: 10,
  responsiveClass: true,
  autoplay: false,
  autoplayTimeout: 4000,
  autoplayHoverPause: true,
  dots: true,
  responsive: {
    0: {
      items: 1,
      nav: false
    },
    600: {
      items: 2,
      nav: false
    },
    1000: {
      items: 2,
      nav: true,
      navText: ["<i class='fa fa-chevron-left'></i>", "<i class='fa fa-chevron-right'></i>"]
    }
  }
});

$('.slide-receita').owlCarousel({
  loop: true,
  margin: 10,
  responsiveClass: true,
  autoplay: false,
  autoplayTimeout: 4000,
  autoplayHoverPause: true,
  dots: true,
  responsive: {
    0: {
      items: 1,
      nav: false
    },
    600: {
      items: 3,
      nav: false
    },
    1000: {
      items: 4,
      nav: true,
      navText: ["<i class='fa fa-chevron-left'></i>", "<i class='fa fa-chevron-right'></i>"]
    }
  }
});



// Function to reveal lightbox and adding YouTube autoplay
function revealVideo(div,video_id) {
  var video = document.getElementById(video_id).src;
  document.getElementById(video_id).src = video+'&autoplay=1'; // adding autoplay to the URL
  document.getElementById(div).style.display = 'block';
}

// Hiding the lightbox and removing YouTube autoplay
function hideVideo(div,video_id) {
  var video = document.getElementById(video_id).src;
  var cleaned = video.replace('&autoplay=1',''); // removing autoplay form url
  document.getElementById(video_id).src = cleaned;
  document.getElementById(div).style.display = 'none';
}

/* 
$(document).ready(function() {


  
  var $videoSrc;  
  $('.video-btn').click(function() {
      $videoSrc = $(this).data( "src" );
  });
  console.log($videoSrc);
  $('#myModal').on('shown.bs.modal', function (e) {
      
  $("#video").attr('src',$videoSrc + "?autoplay=1&amp;modestbranding=1&amp;showinfo=0" ); 
  })
    
  $('#myModal').on('hide.bs.modal', function (e) {
      $("#video").attr('src',$videoSrc); 
  }) 
  });
   */
  
  