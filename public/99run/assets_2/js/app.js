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

$('.serieslist').owlCarousel({
  loop: true,
  margin: 10,
  nav: false,
  responsive: {
    0: {
      items: 1
    },
    600: {
      items: 3
    },
    1000: {
      items: 5
    }
  }
})

$('.videosepisodios').owlCarousel({
  loop: true,
  margin: 10,
  nav: false,
  responsive: {
    0: {
      items: 1
    },
    600: {
      items: 3
    },
    1000: {
      items: 4
    }
  }
})

$('.eplist2').owlCarousel({
  loop: false,
  margin: 10,
  nav: true,
  dots: false,
  navText: ["<i class='fa fa-chevron-left'></i>", "<i class='fa fa-chevron-right'></i>"],
  responsive: {
    0: {
      items: 1
    },
    600: {
      items: 3
    },
    1000: {
      items: 4
    }
  }
})



$('#eplist').owlCarousel({
  loop: false,
  margin: 10,
  nav: true,
  dots: false,
  navText: ["<i class='fa fa-chevron-left'></i>", "<i class='fa fa-chevron-right'></i>"],
  responsive: {
    0: {
      items: 1
    },
    600: {
      items: 3
    },
    1000: {
      items: 6
    }
  }
})



// Function to reveal lightbox and adding YouTube autoplay
function revealVideo(div, video_id) {
  var video = document.getElementById(video_id).src;
  document.getElementById(video_id).src = video + '&autoplay=1'; // adding autoplay to the URL
  document.getElementById(div).style.display = 'block';
}

// Hiding the lightbox and removing YouTube autoplay
function hideVideo(div, video_id) {
  var video = document.getElementById(video_id).src;
  var cleaned = video.replace('&autoplay=1', ''); // removing autoplay form url
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

  window.requestAnimFrame = (function () {
    return window.requestAnimationFrame ||
      window.webkitRequestAnimationFrame ||
      window.mozRequestAnimationFrame ||
      function (callback) {
        window.setTimeout(callback, 1000 / 60);
      };
  })();

  var canvas = $('canvas')[0];
  var cxt = canvas.getContext('2d');
  var width = $('canvas').width();
  var height = $('canvas').height();
  canvas.width = width;
  canvas.height = height;
  var center = {
    x: width / 2,
    y: height / 2
  };
  var value = .78;
  var initialValue = 0;

  var rotation = Math.random() * Math.PI * 2;

  var draw = function () {
    rotation += .001;

    if (rotation >= Math.PI * 2)
      rotation -= Math.PI * 2;

    if (Math.abs(initialValue - value) < .001)
      initialValue = value;

    if (initialValue != value) {
      initialValue += (value - initialValue) / 50;
      $('.widget h2').html('<i class="fas fa-play"></i>');
    }

    cxt.clearRect(0, 0, width, height);
    cxt.save();

    cxt.translate(center.x, center.y);
    cxt.rotate(rotation)

    cxt.lineWidth = 35;
    cxt.beginPath();
    cxt.arc(0, 0, 100, 0, Math.PI * 2, false);
    var grad = cxt.createLinearGradient(0, 0, 0, height);
    grad.addColorStop(0, '#f83131');
    grad.addColorStop(1, '#f83131');
    cxt.strokeStyle = grad;
    cxt.shadowBlur = 10;
    cxt.shadowColor = "rgba(0,0,0,.5)";
    cxt.shadowOffsetX = 0;
    cxt.shadowOffsetY = 4;
    cxt.stroke();

    cxt.beginPath();
    cxt.arc(0, 0, 120, rotation, Math.PI * 2 * initialValue + rotation, false);
    grad = cxt.createLinearGradient(0, 0, 0, height);
    grad.addColorStop(0, '#ff5a5a');
    grad.addColorStop(1, '#ff5a5a');
    cxt.strokeStyle = grad;
    cxt.shadowBlur = 10;
    cxt.shadowColor = "rgba(0,0,0,.5)";
    cxt.shadowOffsetX = 0;
    cxt.shadowOffsetY = 4;
    cxt.stroke();

    cxt.restore();
    requestAnimFrame(draw);
  }
  draw();