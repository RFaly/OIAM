$(document).ready(function () {
    // check mail
    $('#mail-mail').on('input', function () {
        check_mail($(this), $('#mail-mail-error'));
    });
    // check confirmation
    $('#cpass-r').focusout(function () {
        check_cpass($(this), $('#mail-mail-error'));
    });

    function check_mail(testee, value) {
        var pattern = /^([a-zA-Z0-9_\.\-\+])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
        if (pattern.test(testee.val())) {
            testee.css('box-shadow', '0px 1px 5px 1px #e3d7bf');
            testee.css('outline', '2px solid #e3d7bf ');
            testee.css('outline-offset', '-2px');
            value.hide();
        } else {
            testee.css('outline', '.2px solid red');
            testee.css('outline-offset', '-0.2px');
            value.html('(Adresse email invalide)');
            value.show();
        }
    }
    // fonction check confirme passe word
    function check_cpass(test, value) {
        var name1 = test.val();
        var name2 = $('#password-r').val();
        if (name1 != name2) {
            test.css('outline', '.2px solid red');
            test.css('outline-offset', '-0.2px');
            value.html('(Password confirmation ne concorde pas avec Password)');
            value.show();
        } else {
            test.css('box-shadow', '0px 1px 5px 1px #e3d7bf');
            test.css('outline', '2px solid #e3d7bf ');
            test.css('outline-offset', '-2px');
            value.hide();
        }
    }
})
// fonction check mail