// global variables
toastr.options = {
    "closeButton": false,
    "debug": false,
    "newestOnTop": false,
    "progressBar": true,
    "positionClass": "toast-bottom-full-width",
    "preventDuplicates": false,
    "onclick": null,
    "showDuration": "300",
    "hideDuration": "1000",
    "timeOut": "5000",
    "extendedTimeOut": "1000",
    "showEasing": "swing",
    "hideEasing": "linear",
    "showMethod": "fadeIn",
    "hideMethod": "fadeOut"
};

var dateRangePickerGlobalConfig = {
    locale: {
        format: "YYYY-MM-DD hh:mm A",
        separator: " ~ ",
        applyLabel: "적용",
        cancelLabel: "취소",
        fromLabel: "From",
        toLabel: "To",
        customRangeLabel: "직접 선택",
        weekLabel: "W",
        daysOfWeek: ["<span style='color: #dc3545'>일</span>", "월", "화", "수", "목", "금", "<span style='color: #007bff'>토</span>"],
        monthNames: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
        firstDay: 0
    },
    autoUpdateInput: false,
    startDate: moment().subtract(1, 'days').format('YYYY-MM-DD')
};

var dateTimePickerGlobalConfig = {
    format: 'YYYY-MM-DD HH:mm',
    icons: {
        time: "far fa-clock",
        date: "far fa-calendar-alt",
        up: "fa fa-arrow-up",
        down: "fa fa-arrow-down"
    },
    locale: 'ko',
    calendarWeeks: true
};

// 뒤로가기 or 목록
function back(defaultUrl) {
    var detailUrl = document.referrer.substr(document.referrer.indexOf(defaultUrl) + defaultUrl.length);
    let numberOfEntries = window.history.length
    if (numberOfEntries > 1 && document.referrer.indexOf(defaultUrl) > -1 && detailUrl.length == 0) {
        history.back();
    } else {
        if (defaultUrl.indexOf("/") !== 0) {
            defaultUrl = "/" + defaultUrl;
        }
        location.href = contextPath + defaultUrl;
    }
}

// toaster, alert
function successToastr(message) {
    toastr.success(message);
}

function errorToastr(message) {
    toastr.error(message);
}

function warningToastr(message) {
    toastr.warning(message);
}

var blue = "#007bff";
var red = "#dc3545";
var yellow = "#ffc107";

function _alertConfirm(callback, title, text, icon, buttonText, cancelText, confirmBtnColor, cancelBtnColor) {
    Swal.fire({
        title: title || 'Are you sure?',
        text: text || "",
        icon: icon || 'warning',
        showConfirmButton: buttonText != null,
        showCancelButton: cancelText != null,
        confirmButtonColor: confirmBtnColor || '#007bff',
        cancelButtonColor: cancelBtnColor || '#6c757d',
        confirmButtonText: buttonText,
        cancelButtonText: cancelText,
        timer: buttonText !== undefined ? 0 : 1500
    }).then(function (result) {
        if (callback !== null && callback !== undefined) {
            if (result.value) {
                callback(true);
            }
        }
    })
    //icon success, error, warning, info, qustion
}

function alertConfirm(callback, title, text, buttonText, cancelText, confirmBtnColor, cancelBtnColor) {
    _alertConfirm(callback, title, text, "warning", buttonText || "확인", cancelText || "취소", confirmBtnColor, cancelBtnColor);
}

function alertSuccessAfterCallback(callback, title, text, buttonText) {
    _alertConfirm(callback, title, text, "success", buttonText || '확인', null, null, null);
}

function deleteConfirm(callback) {
    _alertConfirm(callback, "삭제하시겠습니까?", "삭제시 되돌릴 수 없습니다.", "warning", "삭제", "취소", '#dc3545', '#6c757d');
}

function logoutConfirm(callback) {
    _alertConfirm(callback, "로그아웃 하시겠습니까?", "", 'warning', "로그아웃", "취소")
}

function alertSuccess(message, confirmText) {
    _alertConfirm(null, message, "", "success", confirmText, null, null, null);
}

function alertFailed(message, confirmText) {
    _alertConfirm(null, message, "", "error", confirmText, null, null, null);
}
function alertWarning(message, confirmText) {
    _alertConfirm(null, message, "", "warning", confirmText, null, null, null);
}

function alertRegistered() {
    alertSuccess("등록되었습니다!");
}

function alertUpdated() {
    alertSuccess("수정되었습니다!");
}

function alertUpdatedAfterCallback(callback) {
    alertSuccessAfterCallback(callback, "수정되었습니다!");
}

function alertDeleted() {
    alertSuccess("삭제되었습니다!");
}

function alertDeletedAfterCallback(callback) {
    alertSuccessAfterCallback(callback, "삭제되었습니다!");
}

function displayErrors(data, idx) {
    _displayErrors(data.responseJSON.errors);
}

function _displayErrors(errors, idx) {
    clearInvalid();
    if (errors.length > 0) {
        $.each(errors, function (index, item) {
            if (item.field) {
                displayInvalid(item.field, item.reason, idx);
            } else {
                errorToastr(item.reason);
            }
        });
    }
}

function displayInvalid(field, reason, idx) {
    field = field.replace(/[\.,\[,\]]/g, "-");
    if (idx != null) {
        field = field + "-" + idx + "-";
    }
    reason = reason.replace(/\n/g, "<br>");
    $("[name=" + field + "]").addClass('is-invalid');
    $("[name=" + field + "]").focus();
    $("#" + field + "Error").show().append(reason + "<br/>");
}

function clearInvalid() {
    $('.is-invalid').removeClass('is-invalid');
    $('.invalid-feedback').empty().hide();
}

function formatNumber(val, char) {
    var defaultValue = char == null ? "" : char;
    if (val == null) {
        return defaultValue;
    }
    //return String(val).replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
    return '';
}

// quill editor
var quillToolbarOptions = [
    ['bold', 'italic', 'underline', 'strike'],        // toggled buttons
    ['blockquote'/*, 'code-block'*/],

    [{'header': 1}, {'header': 2}],               // custom button values
    [{'list': 'ordered'}, {'list': 'bullet'}],
    [{'script': 'sub'}, {'script': 'super'}],      // superscript/subscript
    [{'indent': '-1'}, {'indent': '+1'}],          // outdent/indent
    [{'direction': 'rtl'}],                         // text direction

    // [{ 'size': ['small', false, 'large', 'huge'] }],  // custom dropdown
    [{'size': [false, 'large']}],  // custom dropdown
    // [{ 'header': [1, 2, 3, 4, 5, 6, false] }],

    [{'color': []}, {'background': []}],          // dropdown with defaults from theme
    [{'font': []}],
    [{'align': []}],
    ['image', 'video', 'link'],

    ['clean']                                         // remove formatting button
];

var quillOptions = {
    // debug: 'info',
    // bounds: '#editor-bound',
    modules: {
        toolbar: {
            container: quillToolbarOptions,
            handlers: {
                'image': quillUploadImage
            }
        }
    },
    // scrollingContainer: '#scrolling-container',
    placeholder: '내용을 입력해주세요..',
    // readOnly: true,
    theme: 'snow'
};

function quillUploadImage() {
    var input = document.createElement('input');
    input.setAttribute('type', 'file');
    input.click();
    var quill = this.quill;

    input.onchange = function () {
        var fd = new FormData();
        var file = $(this)[0].files[0];
        fd.append('image', file);

        $.ajax({
            type: 'post',
            enctype: 'multipart/form-data',
            url: contextPath + '/files/upload',
            data: fd,
            processData: false,
            contentType: false,
            /*beforeSend: function(xhr) {
                xhr.setRequestHeader($("#_csrf_header").val(), $("#_csrf").val());
            },*/
            success: function (data) {
                var range = quill.getSelection();
                quill.insertEmbed(range.index, 'image',
                    contextPath + '/files/preview/' + data[0].url);
            },
            error: function (err) {
                console.error("Error ::: " + err);
            }
        });
    };
}

function isEmpty(param) {
    return Object.keys(param).length === 0 && param.constructor === Object;
}

// dateRangePicker set date
var setDateRange = function (start, end) {
    if (start._isValid && end._isValid) {
        $('#dateRangePicker').val(start.format('YYYY-MM-DD') + ' ~ ' + end.format('YYYY-MM-DD'));
        $('[name=startDate]').val(start.format('YYYY-MM-DD'));
        $('[name=endDate]').val(end.format('YYYY-MM-DD'));
    } else {
        $('#dateRangePicker').data('daterangepicker').setStartDate(moment());
        $('#dateRangePicker').data('daterangepicker').setEndDate(moment());
        $('#dateRangePicker').val('');
        $('[name=startDate]').val('');
        $('[name=endDate]').val('');
    }
};

function dimShow() {
    $('.dimming-backdrop').addClass('show');
}

function dimHide() {
    $('.dimming-backdrop').removeClass('show');
}

function showLoading(text) {
    if (text != null) {
        $('#loading-container .title').text(text);
    }
    dimShow();
    $('#loading-container').show();

}

function hideLoading() {
    dimHide();
    $('#loading-container').hide();
}

function isMobile() {
    var filter = "win16|win32|win64|mac|macintel";
    if (navigator.platform) {
        return filter.indexOf(navigator.platform.toLowerCase()) < 0;
    }
    return false;
}

function formatPhone(val) {
    if (val == null) {
        return "";
    }
    var formatNum = "";
    var number = val + "";
    if (number.length === 11) {
        formatNum = number.replace(/(\d{3})(\d{4})(\d{4})/, "$1-$2-$3");
    } else if (number.length === 8) {
        formatNum = number.replace(/(\d{4})(\d{4})/, "$1-$2");
    } else {
        if (number.indexOf("02") === 0) {
            formatNum = number.replace(/(\d{2})(\d{4})(\d{4})/, "$1-$2-$3");
        } else {
            formatNum = number.replace(/(\d{3})(\d{3})(\d{4})/, "$1-$2-$3");
        }
    }
    return formatNum;
}

function dateFormat(datetimeText, format) {
    if (datetimeText == null) {
        return "-";
    }
    var formatText = format || 'YYYY-MM-DD HH:mm:ss';
    return moment(datetimeText).format(formatText);
}

function getDay(date){
    let d = moment(date);
    let day = '';
    switch(d.day())
    {
        case 0:
            day = '일';
            break;
        case 1:
            day = '월';
            break;
        case 2:
            day = '화';
            break;
        case 3:
            day = '수';
            break;
        case 4:
            day = '목';
            break;
        case 5:
            day = '금';
            break;
        case 6:
            day = '토';
            break;
    }

    return day;
}

function empty(val) {
    return val == null ? "-" : val;
}

function formatCardNumber(value) {
    if (value == null) {
        return "-";
    }
    return value.replace(/(\d{4})(\d{4})(\d{4})(\d{4})/, "$1-$2-$3-$4");
}

function rowNumber(index, page, sort) {
    sort = sort == null ? 'desc' : sort;
    var rowNumber = 0;
    var calcTempRowNumber = page.number * page.size + index+1;

    if(page.totalElements != null && page.totalElements !== '' && sort === 'desc') {
        rowNumber = page.totalElements + 1 - calcTempRowNumber;
    } else if(sort === 'asc') {
        rowNumber = calcTempRowNumber;
    }
    return rowNumber;
}

function chargerStatusClassName(code) {
    if (code === '1' || code === '2') {
        return "badge-danger";
    } else if (code === '4') {
        return 'badge-warning';
    } else {
        return "badge-white";
    }
}

function jsonToFormData(jsonData) {
    var formData = new FormData();
    for (var key in jsonData) {
        formData.append(key, jsonData[key]);
    }
    return formData;
}

$(function () {
    $('#viewPageSize').change(function () {
        var uri = new URI(window.location);
        uri.setSearch("size", $('#viewPageSize').val());
        location.href = uri;
    });

    $('#viewDataTablePageSize').change(function () {
        dataTable.page.len($('#viewDataTablePageSize').val()).draw();
    });
})

function chargingTimeFormat(value) {
    if (value == null) {
        return "-";
    } else {
        return value.substr(0,2) + ":" + value.substr(2,2) + ":" + value.substr(4,2);
    }
}

function initDatePicker() {
    var startDate = $('input[name="startDateTemp"]').val() || null;
    var endDate = $('input[name="endDateTemp"]').val() || null;
    $('#startDate').datetimepicker($.extend(true, dateTimePickerGlobalConfig,
        {format: 'YYYY-MM-DD', useCurrent: false, defaultDate: startDate}));
    $("#startDate").on("change.datetimepicker", function (e) {
        $('#endDate').datetimepicker('minDate', e.date);
    });

    $('#endDate').datetimepicker($.extend(true, dateTimePickerGlobalConfig,
        {format: 'YYYY-MM-DD', useCurrent: false, defaultDate: endDate}));
    $("#endDate").on("change.datetimepicker", function (e) {
        $('#startDate').datetimepicker('maxDate', e.date);
    });
}

function setRange(value) {
    if (value === 0) {
        setFrom('');
        setTo('');
    } else {
        setFrom(moment().subtract(value, 'month').format('YYYY-MM-DD'));
        setTo(moment().format('YYYY-MM-DD'));
    }
}

function setFrom(val) {
    $('input[name="startDate"]').val(val);
    $('input[name="startDateTemp"]').val(val);
}

function setTo(val) {
    $('input[name="endDate"]').val(val);
    $('input[name="endDateTemp"]').val(val);
}

/**
 * 쿠키 셋팅
 */
function setCookie(cName, cValue, cDay) {
    var expire = new Date();
    expire.setDate(expire.getDate() + cDay);
    cookies = cName + '=' + escape(cValue) + '; path=/ ';
    if (typeof cDay != 'undefined')
        cookies += ';expires=' + expire.toGMTString() + ';';
    document.cookie = cookies;
};

/**
 * 쿠키 가져오기
 */
function getCookie(cName) {
    cName = cName + '=';
    var cookieData = document.cookie;
    var start = cookieData.indexOf(cName);
    var cValue = '';
    if (start != -1) {
        start += cName.length;
        var end = cookieData.indexOf(';', start);
        if (end == -1)
            end = cookieData.length;
        cValue = cookieData.substring(start, end);
    }
    return unescape(cValue);
};


$.datetimepicker.setLocale('ko');

function initDateTimePicker()
{

    try {
        $('.date').datetimepicker({
            format:'Y-m-d',
            timepicker:false
        });

        $('.time').datetimepicker({
            format:'H:i',
            datepicker:false
        });

        $('.datetime').datetimepicker({
            format:'Y-m-d H:i',
        });
    } catch (e) {
    }
}

function initSkin()
{
    if (getCookie('skin') != '')
    {
        $('img').each(function(){
            var splitVal = $(this).attr('src').split('/');
            $(this).attr('src', '/resources/img/black/' + splitVal[splitVal.length-1])
        });
    }
}

function comma(str)
{
    if(str == null || str == '')
        return 0;

    return new String(str).split(/(?=(?:\d{3})+(?:\.|$))/g).join(',');
}


function htmlConvert(data) {
    if (data == null || data == '') {
        return '-';
    } else {
        return String(data).replace(/(?:\r\n|\r|\n)/g, '<br/>');
    }
}

function htmlDecode(input) {
    const doc = new DOMParser().parseFromString(input, "text/html");
    return doc.documentElement.textContent;
}

/**
 * Util script
 */
(function ($) {

    /**
     * 메시지 일정시간 표출
     */
    jQuery.fn.showMsg = function (msg, duration, callbackFunc) {
        var delay = duration !== undefined ? duration : 3000;
        var el = $(this);
        $(el).parent().fadeIn();
        $(el).text(msg);
        setTimeout(function () {
            $(el).text('');
            $(el).parent().fadeOut();
            if (callbackFunc !== undefined)
                callbackFunc();
        }, delay);
    };

    /**
     * sting to 통화형식
     */
    jQuery.comma = function (str) {
        str = String(str);
        return str.split(/(?=(?:\d{3})+(?:\.|$))/g).join(',');
    };

    /**
     * 요소 텍스트 to 통화형식
     */
    jQuery.fn.comma = function () {
        $(this).text($(this).text().split(/(?=(?:\d{3})+(?:\.|$))/g).join(','));
    };

    /**
     * 입력박스 to 통화형식
     */
    jQuery.fn.commaVal = function () {
        var val = $(this).val().replace(/[^\d]+/g, '');
        $(this).val(val.split(/(?=(?:\d{3})+(?:\.|$))/g).join(','));
    };

    /**
     * 통화형식 제거
     */
    jQuery.uncomma = function (str) {
        str = String(str);
        return str.replace(/[^\d]+/g, '');
    };

    /**
     * 한글 입력값 확인
     */
    jQuery.fn.isKorean = function (str) {

        check = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;

        if (str !== undefined)
            return check.test(str) ? true : false;

        return check.test($(this).val()) ? true : false;


    };

    /**
     * mouse event
     */
    $.fn.longClick = function (callback, timeout) {
        var timer;
        timeout = timeout || 500;
        $(this).mousedown(function () {
            var el = $(this);
            timer = setTimeout(function () {
                callback(el);
            }, timeout);
            return false;
        });
        $(document).mouseup(function () {
            clearTimeout(timer);
            return false;
        });
    };

    /**
     * focus event with number
     */
    $.fn.focusNum = function () {
        $(this).on('focusin', function () {
            if ($(this).val() == '0')
                $(this).val('');
        });
        $(this).on('focusout', function () {
            if ($(this).val() == '')
                $(this).val('0');
        });
    };

    $.fn.ajaxForm = function (opt) {

        var funcSuccess = opt.success === undefined ? function(){} : opt.success;
        var funcError 	= opt.error === undefined ? function(e,t,h){$('.msg-wrap').showMsg('서버 에러! 관리사에 문의하세요');} : opt.error;

        $(this).on('submit', function(e){
            e.preventDefault();
            var form = e.target;

            $(form).find('.input-comma').each(function(){
                $(this).val($(this).val().replace(/[^0-9]/g,""));
            });

            //var data = new FormData(form);
            var data = $(form).serialize();

            $.ajax({
                url: form.action,
                method: form.method,
//				processData: false,
//				contentType: false,
                beforeSend : function(){
                    showLoading();
                },
                data: data,
                success: funcSuccess,
                error:funcError,
                complete: function(){
                    hideLoading();
                }
            });
        });
    };

    $.fn.ajaxFormData = function (opt) {

        var funcSuccess = opt.success === undefined ? function(){} : opt.success;
        var funcError 	= opt.error === undefined ? function(e,t,h){$('.msg-wrap').showMsg('서버 에러! 관리사에 문의하세요');} : opt.error;

        $(this).on('submit', function(e){
            e.preventDefault();

            var form = e.target;

            $(form).find('.input-comma').each(function(){
                $(this).val($(this).val().replace(/[^0-9]/g,""));
            });

            var data = new FormData(form);


            $.ajax({
                url: form.action,
                method: form.method,
                processData: false,
                contentType: false,
                beforeSend : function(){
                    showLoading();
                },
                data: data,
                success: funcSuccess,
                error:funcError,
                complete: function(){
                    hideLoading();
                }
            });
        });
    };

})(jQuery);