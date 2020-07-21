

$(document).on("click",".comment",function () {
    var id = $(this).attr("id");
    if (id==="no-login") {

    } else {
        document.getElementById(`comment-input-field-${id}`).focus()
    }
});



