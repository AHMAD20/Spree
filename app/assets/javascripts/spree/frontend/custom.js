// $(document).ready(function(){
//     $('.search a').click(function(){
//         $(this).parent('.search').toggleClass('active');
//     });
// })

var ready = function() {
    // do stuff here.
    $('.search a').click(function(){
        $(this).parent('.search').toggleClass('active');
    });
    $('.search-close').click(function(){
        $('.search').removeClass('active');
    });
    return false;
};

$(document).ready(ready);
$(document).on('turbolinks:load','click', ready);

