Vue.filter("dayOfWeek", function (val, length) {
    if (val == null || val === '') {
        return "-";
    }
    var shortWeeks = ['일', '월', '화', '수', '목', '금', '토'];
    var longWeeks = ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'];

    var weeks = length != null && length > 1 ? longWeeks : shortWeeks;
    return weeks[moment(val).format('e')];
});
Vue.filter("formatNumber", function (val) {
    if (val == null) {
        return "";
    }
    return String(val).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
});
Vue.filter("formatDateOfPattern", function (val, pattern) {
    if (val == null || val === '') {
        return "-";
    }
    return moment(val).format(pattern);
});
Vue.filter("formatDateTime", function (val, format) {
    if (val == null || val === '') {
        return "-";
    }
    return moment(val).format(format || "YYYY-MM-DD HH:mm:ss");
});
Vue.filter("formatDate", function (val, format) {
    if (val == null || val === '') {
        return "-";
    }
    return moment(val).format(format || "YYYY-MM-DD");
});
Vue.filter("empty", function (val, char) {
    var character = char == null ? '' : char;
    if (val === null || val === undefined || val === '' || val === -999) {
        return character;
    } else {
        return val;
    }
});
Vue.filter("view", function (val) {
    return "/files/view/" + val;
})
Vue.filter("lpad", function (val, width) {
    if (width == null) {
        width = 2;
    }
    val = val + '';
    return val.length >= width ? val : new Array(width - val.length + 1).join('0') + val;
})
Vue.filter('formatPhone', function (val) {
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
});

Vue.filter('mask', function (val) {
    if (val === null) {
        return "";
    }
    var maskLength = val.length < 5 ? 1 : 2;
    var s = val.substr(0, val.length - maskLength);
    return s + new Array(maskLength + 1).join('*');
})

Vue.filter('rowNum', function (index, page, sort) {
    return rowNumber(index, page, sort);
});

Vue.filter('reverse', function (value) {
    return value.slice().reverse();
});

Vue.filter('numbers', function (value) {
    return Number(value);
});

Vue.filter('round', function (value, idx) {
    return Number(value).toFixed(idx);
})

Vue.filter('formatCardNumber', function (value) {
    return formatCardNumber(value);
})
