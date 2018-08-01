// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function() {
    $(document).on('click', '.toggle-ballon-animation', function(e) {
        e.preventDefault();
        console.log('click');
        $('.balloon-animation-wrapper').toggle();
    });
});
