'use strict'
$(document).ready(function () {

    var html = $('html');
    var body = $('body');

    /* create cookie */
    function setCookie(cname, cvalue, exdays) {
        const d = new Date();
        d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
        let expires = "expires=" + d.toUTCString();
        document.cookie = cname + "=" + cvalue + ";" + expires + ";  path=/; SameSite=None; Secure";
    }

    function getCookie(cname) {
        let name = cname + "=";
        let ca = document.cookie.split(';');
        for (let i = 0; i < ca.length; i++) {
            let c = ca[i];
            while (c.charAt(0) == ' ') {
                c = c.substring(1);
            }
            if (c.indexOf(name) == 0) {
                return c.substring(name.length, c.length);
            }
        }
        return "";
    }


    /* sidebar right color scheme */
    if (getCookie("onefincelayoutmode") === 'dark-mode') {
        $('#btn-layout-modes-light').prop('checked', false);
        $('#btn-layout-modes-dark').prop('checked', true);
        $('#darkmodeswitch').prop('checked', true);
        html.addClass('dark-mode');
    } else {
        $('#btn-layout-modes-light').prop('checked', true);
        $('#btn-layout-modes-dark').prop('checked', false);
        html.removeClass('dark-mode');
    }

    $('#btn-layout-modes-light').on('click', function () {
        if ($(this).is(':checked')) {
            setCookie('onefincelayoutmode', 'light-mode', 1);
            html.attr('class', getCookie("onefincelayoutmode"));
        } else { }
    });

    $('#btn-layout-modes-dark').on('click', function () {
        if ($(this).is(':checked')) {
            setCookie('onefincelayoutmode', 'dark-mode', 1);
            html.attr('class', getCookie("onefincelayoutmode"));
        } else { }
    });


    $('#darkmodeswitch').on('click', function () {
        if ($(this).is(':checked')) {
            setCookie('onefincelayoutmode', 'dark-mode', 1)
            html.attr('class', getCookie("onefincelayoutmode"));
        } else {
            setCookie('onefincelayoutmode', 'light-mode', 1)
            html.attr('class', getCookie("onefincelayoutmode"));
        }
    });

    /* Right to left to right directions  */
    if (getCookie('onefincedirectionmode') === 'rtl') {
        $('#btn-ltr').prop('checked', false);
        $('#btn-rtl').prop('checked', true);
        body.addClass('rtl');

        $('.bi-chevron-right').addClass('bi-chevron-left').removeClass('bi-chevron-right')
        $('.bi-arrow-right').addClass('bi-arrow-left').removeClass('bi-arrow-right')
        $('.bi-arrow-left').addClass('bi-arrow-right').removeClass('bi-arrow-left')

    } else {
        $('#btn-ltr').prop('checked', true);
        $('#btn-rtl').prop('checked', false);
        body.removeClass('rtl');
    }

    $('#btn-ltr').on('click', function () {
        if ($(this).is(':checked')) {
            setCookie('onefincedirectionmode', 'ltr', 1);
            body.addClass('ltr');
            body.removeClass('rtl');
        } else { }
    });

    $('#btn-rtl').on('click', function () {
        if ($(this).is(':checked')) {
            setCookie('onefincedirectionmode', 'rtl', 1);
            body.addClass('rtl');
            body.removeClass('ltr');
        } else { }
    });



    /* color style  */
    var curentstyle;
    var defaultStyle = "theme-orange";
    if ($.type(getCookie("onefincesetstylesheet")) != 'undefined' && getCookie("onefincesetstylesheet") != '') {
        body.removeClass(defaultStyle);

        curentstyle = getCookie("onefincesetstylesheet");
        body.addClass(getCookie("onefincesetstylesheet"));
        $('input[name="color-scheme"]').each(function () {
            if ($(this).attr('data-title') === getCookie("onefincesetstylesheet")) {
                $(this).prop("checked", true);
            }
        });
    } else {
    }

    $('input[name="color-scheme"]').on('click', function () {
        body.removeClass(defaultStyle);
        var setstyle = $(this).attr('data-title');

        if ($(this).is(':checked') && setstyle != '') {
            body.removeClass(curentstyle);
            setCookie('onefincesetstylesheet', setstyle, 1);
            body.addClass(getCookie("onefincesetstylesheet"));
            curentstyle = getCookie("onefincesetstylesheet");

        } else {
            body.removeClass(curentstyle);
            setCookie('onefincesetstylesheet', '', 1);
        }

    });


    /* background images */
    if ($.type(getCookie("onefincesetimagepath")) != 'undefined' && getCookie("onefincesetimagepath") != '') {
        $('main').addClass(getCookie("onefincesetimagepath"));
        $('input[name="background-select"]').each(function () {
            if ($(this).attr('data-src') === getCookie("onefincesetimagepath")) {
                $(this).prop("checked", true);
            }
        });
    }
    $('input[name="background-select"]').on('click', function () {
        $('main').removeClass(getCookie("onefincesetimagepath"));
        var setimage = $(this).attr('data-src');
        if ($(this).is(':checked')) {
            setCookie('onefincesetimagepath', setimage, 1);
            $('main').addClass(setimage);
        }
    });

    /* sidebar type */
    if ($.type(getCookie("onefincesetmenu")) != 'undefined' && getCookie("onefincesetmenu") != '') {
        $('.sidebar-wrap').attr('class', 'sidebar-wrap square-sidebar');
        $('.sidebar-wrap').addClass('sidebar-' + getCookie("onefincesetmenu"));

        $('input[name="menu-select"]').each(function () {
            if ($(this).attr('data-title') === getCookie("onefincesetmenu")) {
                $(this).prop("checked", true);
            }
        });
    }
    $('input[name="menu-select"]').on('click', function () {
        var onefincesetmenustyle = $(this).attr('data-title');
        if ($(this).is(':checked')) {
            setCookie('onefincesetmenu', onefincesetmenustyle, 1);
            $('.sidebar-wrap').attr('class', 'sidebar-wrap square-sidebar');
            $('.sidebar-wrap').addClass('sidebar-' + getCookie("onefincesetmenu"));
        }
    });


});