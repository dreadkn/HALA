<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>

<!-- Control Sidebar -->
<aside class="control-sidebar control-sidebar-dark">
    <!-- Control sidebar content goes here -->
    <div class="p-3">
        <h5>Layout Option</h5>
        <p></p>
        <%--<div class="mb-1"><label><input type="checkbox" value="1" class="mr-1"><span>Fixed Sidebar</span></label>
            <p>Activate the fixed layout. You can't use fixed and boxed layouts together</p>
        </div>--%>
        <div class="mb-1"><label>
            <input id="c-toggle-sidebar" type="checkbox" value="1" class="mr-1" onchange="toggleSidebarListener(this)" ${toggleSidebar eq '1' ? 'checked' : ''}>
            <span>Toggle Sidebar</span>
        </label></div>
        <div class="mb-1"><label>
            <input type="checkbox" value="1" class="mr-1" onchange="flatSidebar(this)" ${navFlat eq '1' ? 'checked' : ''}>
            <span>Sidebar nav flat style</span>
        </label></div>

    </div>
</aside>
<!-- /.control-sidebar -->

<script>
    function toggleSidebar() {
        $('#c-toggle-sidebar').trigger("click");
    }
    function toggleSidebarListener($event) {
        if ($($event).is(":checked")) {
            var options = {expires: moment().add(1, 'years').toDate()};
            // $('body').addClass('sidebar-collapse');
            setCookie("toggleSidebar", "1", options);
        } else {
            // $('body').removeClass('sidebar-collapse');
            deleteCookie("toggleSidebar");
        }
    }

    function flatSidebar($event) {
        if ($($event).is(":checked")) {
            var options = {expires: moment().add(1, 'years').toDate()};
            $('ul.nav.nav-sidebar').addClass('nav-flat');
            setCookie("navFlat", "1", options);
        } else {
            $('ul.nav.nav-sidebar').removeClass('nav-flat');
            deleteCookie("navFlat");
        }
    }

    function setCookie(name, value, options) {
        var baseOptions = {
            path: '/'
        };
        $.extend(true, baseOptions, options);

        if (options.expires instanceof Date) {
            options.expires = options.expires.toUTCString();
        }

        var updatedCookie = encodeURIComponent(name) + "=" + encodeURIComponent(value);

        for (var optionKey in options) {
            updatedCookie += "; " + optionKey;
            var optionValue = options[optionKey];
            if (optionValue !== true) {
                updatedCookie += "=" + optionValue;
            }
        }
        document.cookie = updatedCookie;
    }
    function deleteCookie(name) {
        setCookie(name, "", {
            'max-age': -1
        })
    }
</script>
