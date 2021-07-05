$(function() {

    livewire.on("showSelect2", data => {
        const selectorId = "" + data[0] + "";
        const selectorData = data[1];
        const selectorOnchange = "" + data[2] + "";

        $(selectorId).select2({
            theme: "classic",
            width: "style"
        });

        if (selectorData) {
            $(selectorId)
                .val(selectorData)
                .trigger("change");
        }

        $(selectorId).on("change", function(e) {
            var data = $(this).select2("val");
            livewire.emit(selectorOnchange, data);
        });
    });


});
