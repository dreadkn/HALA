Vue.mixin({
    methods: {
        chargerStatusClassName: function (code) {
            return chargerStatusClassName(code);
        },
        chargerConnectionClassName: function (isConnection) {
            return isConnection ? 'badge-success' : 'badge-danger';
        },
        chargerStatusCountClassName: function (count, className) {
            if (count === 0) {
                return "text-muted";
            } else {
                return "text-bold " + className;
            }
        },
        pageView: function (pageNumber, pageSize, numberOfElements, totalElements) {
            if (pageNumber == null) {
                return "";
            }
            var start = totalElements === 0 ? 0 : (pageNumber +1) * pageSize - (pageSize -1);
            return Vue.filter('formatNumber')(start)
                + " - " + Vue.filter('formatNumber')((pageNumber+1) * pageSize - (pageSize - numberOfElements))
                + " / " + Vue.filter('formatNumber')(totalElements);
        },
        htmlConvert: function (data) {
            return htmlConvert(data);
        }
    }
})

var mixinForm = {
    computed: {
        isNew: function () {
            return this.id == null || this.id === '';
        },
        isUpdate: function () {
            return this.id != null && this.id !== '';
        }
    }
}
