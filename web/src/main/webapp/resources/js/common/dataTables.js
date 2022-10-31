var dataTableOption = {
    language: {
        infoThousands: ",",
        decimal: ",",
        processing: "<div class='d-flex align-items-center justify-content-center'><div class='spinner-border'></div>&nbsp;&nbsp;조회중...</div>",
        search: "검색&nbsp;:",
        lengthMenu: "페이지당 줄수 _MENU_",
        info: "_START_ - _END_ / _TOTAL_",
        infoEmpty: "0 - 0 / 0",
        infoFiltered: "(총 _MAX_ 개)",
        infoPostFix: "",
        loadingRecords: "읽는중...",
        zeroRecords: "검색 결과가 없습니다",
        emptyTable: "데이터가 없습니다",
        paginate: {
            first: "&laquo;",
            previous: "&lsaquo;",
            next: "&rsaquo;",
            last: "&raquo;"
        },
        aria: {
            sortAscending: ": 오름차순 정렬",
            sortDescending: ": 내림차순 정렬"
        }
    },
    pagingType: "full_numbers",
    processing: true,
    paging: true,
    lengthChange: false,
    searching: false,
    ordering: true,
    info: true,
    autoWidth: false,
    responsive: true,
    serverSide: true,
    stateSave: true,
    pageLength: 10,
    order: [[0, 'asc']],
    ajax: {
        type: 'GET',
        contentType: 'application/json',
        data: flatten
    },
    stateLoadParams: function (settings, data) {
        var uri = new URI(window.location);
        var referrer = document.referrer;
        var href = window.location.href;
        console.log("referrer: " + referrer);
        console.log("href: " + href);
        console.log("!includes: " + !href.includes(referrer));
        if (uri.hasQuery('keyword')) {
            data.start = 0;
        }
        // if (!href.includes(referrer)) {
        //     data.start = 0;
        // }
        settings.ajax.url = settings.ajax.url + getSearch();
    },
    dom: "<'row'<'col-sm-12'tr>>"
    /*dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
        "<'row'<'col-sm-12'tr>>" +
        "<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-12'p>>"*/
}

function flatten(params) {
    params.columns.forEach(function (column, index) {
        params['columns[' + index + '].data'] = column.data;
        params['columns[' + index + '].name'] = column.name;
        params['columns[' + index + '].searchable'] = column.searchable;
        params['columns[' + index + '].orderable'] = column.orderable;
        params['columns[' + index + '].search.regex'] = column.search.regex;
        params['columns[' + index + '].search.value'] = column.search.value;
    });
    delete params.columns;

    params.order.forEach(function (order, index) {
        params['order[' + index + '].column'] = order.column;
        params['order[' + index + '].dir'] = order.dir;
    });
    delete params.order;

    params['search.regex'] = params.search.regex;
    params['search.value'] = params.search.value;
    delete params.search;

    return params;
}

function getSearch() {
    var uri = new URI(window.location);
    $('form').serializeArray().forEach(function (o) {
        if (o.name !== "_csrf") {
            uri.setSearch(o.name, o.value);
        }
    })
    var s = uri.search();
    console.log(s);
    return s;
}
