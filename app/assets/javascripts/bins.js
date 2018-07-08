(function () {

    $(document).on('submit', '#bins-form', function (e) {
        e.preventDefault();
        var $form, content, url;

        $form = $(this);
        $form.removeClass('invalid');
        $('.form-errors').remove();

        url = $form.attr('action');
        content = $form.find('#content').val();
        if (jsonValid(content)) {
            var data = JSON.stringify({ content: JSON.parse(content)});

            $.ajax({
                type: "POST",
                url: url,
                data: data,
                contentType: 'application/json',
                dataType: 'json',
                success: function (response) {
                    appendBinLink(response, $form);
                }
            })
        } else {
            appendErrorMessage($form);
        }

    });

    function jsonValid(json) {
        if (json == '') {
            return false
        }


        try {
            JSON.parse(json);
        } catch (e) {
            return false;
        }
        return true;
    }

    function appendBinLink(response, form) {
        link = "<a href='" + response.url +  "' target='_blank'>" + response.url + "</a>";
        result = "<div class='form-result'><div class='alert alert-success'>" + link + "</div></div>";
        form.append(result)
    }

    function appendErrorMessage(form) {
        $('.form-errors').remove();
        form.addClass('invalid');
        error = "<div class='form-errors'><div class='alert alert-danger'>JSON is not valid! Check it's validness</div></div>";
        form.append(error);
    }
})();