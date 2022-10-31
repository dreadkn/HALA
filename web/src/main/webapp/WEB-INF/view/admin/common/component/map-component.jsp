<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<script type="text/x-template" id="map-component">
    <div id="map-wrapper" class="position-relative w-100 h-100">
        <div id="map" class="w-100 h-100"></div>
        <div class="screen position-absolute w-100 h-100" style="left: 0; top: 0">
            <h4 class="text-white">지도를 확대하려면 Ctrl + 스크롤 사용</h4>
        </div>
    </div>
</script>

<script>
    var map;
    var pushCtrlKey = false;
    var screenTimeout;

    Vue.component("map-component", {
        template: '#map-component',
        props: ["lat", "lng", "locations"],
        mounted: function () {
            document.getElementById("map-wrapper").addEventListener("wheel", onScreen);
        },
        data: function () {
            return {
                map: null
            }
        },
        watch: {
            lat: function () {
              this.initMap();
            }
        },
        methods: {
            initMap: function () {
                var location;
                if (this.lat != null && this.lng != null) {
                    location = new kakao.maps.LatLng(this.lat, this.lng);
                } else {
                    location = new kakao.maps.LatLng(33.4767898, 126.4741519);
                }

                var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
                var options = { //지도를 생성할 때 필요한 기본 옵션
                    center: location, //지도의 중심좌표.
                    maxLevel: 7,
                    level: 4 //지도의 레벨(확대, 축소 정도)
                };
                var zoomControl = new kakao.maps.ZoomControl()
                map = new kakao.maps.Map(container, options);
                map.addControl(new kakao.maps.MapTypeControl(), kakao.maps.ControlPosition.TOPRIGHT);
                map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
                map.setZoomable(false);

                var marker = new kakao.maps.Marker({
                    position: location
                });
                marker.setMap(map);
            }
        }
    });

    $(function () {

    })

    $(window).keydown(function(e){
        if (e.ctrlKey) {
            pushCtrlKey = true;
            $('.screen').removeClass('on');
            setZoomable(true);
        }
    });

    $(window).keyup(function(e){
        pushCtrlKey = false;
        setZoomable(false);
    });

    function onScreen() {
        if (!pushCtrlKey) {
            $('.screen').addClass('on');
            clearTimeout(screenTimeout);
            screenTimeout = setTimeout(function () {
                $('.screen').removeClass('on');
            }, 1000);
        }
    }

    function setZoomable(zoomable) {
        map.setZoomable(zoomable);
    }

</script>
