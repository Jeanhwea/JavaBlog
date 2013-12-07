// JavaScript Document
$(document).ready(function() {
    $("mainLevel").each(function() {
        $(this).find(".cover").css("top", -$(this).height());
        $(this).hover(function() {
            $(this).find(".cover").animate({
                top: "0"
            },
            300)
        },
        function() {
            $(this).find(".cover").animate({
                top: $(this).height()
            },
            {
                duration: 300,
                complete: function() {
                    $(this).css("top", -$(this).parent("li").height())
                }
            })
        })
    })
});
$(document).ready(function() {
    $(".nav2").hover(function() {
        $(this).addClass("hover")
    },
    function() {
        $(this).removeClass("hover")
    });
   
});