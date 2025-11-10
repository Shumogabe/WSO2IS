

$(document).ready(function(){
    var screenW= window.innerWidth;
    if(screenW > 1100){
        $(".header .nav-toggle").click(function(){
            $("body").toggleClass("sidebar-collapsed");
        });
    }else{
        $(".header .nav-toggle").click(function(){
            $(".sidebar").toggleClass("show");
            $(".overlay-common").toggleClass("show");
        });
    }
    $(".overlay-common").click(function(){
        $(".sidebar").removeClass("show");
        $(this).removeClass("show");
    })
});