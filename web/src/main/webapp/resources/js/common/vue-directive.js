Vue.directive('select2', {
    twoWay: true,
    inserted: function (el) {
        $(el).on('select2:select', function () {
            var event = new Event('change', {bubbles: true, cancelable: true});
            el.dispatchEvent(event);
        });

        $(el).on('select2:unselect', function () {
            var event = new Event('change', {bubbles: true, cancelable: true})
            el.dispatchEvent(event)
        })
    }
});
