<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>

<div id="vue-app" class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h4 class="m-0 text-dark">대시보드</h4>
                </div>
                <div class="d-none col-sm-6 d-md-block">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item active">대시보드</li>
                    </ol>
                </div>
            </div>
        </div>
    </div>
    <!-- /.content-header -->

    <!-- Main content -->
    <div class="content">
        <div class="container-fluid">

            <div class="row">
                <div class="col-12">
                    <div class="card card-light <%--collapsed-card--%>">
                        <div class="card-header">
                            <h3 class="card-title">검색 필터</h3>

                            <div class="card-tools">
                                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                    <i class="fas fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <!-- /.card-header -->
                        <div class="card-body pt-2 pb-1">
                            <form @submit.prevent="fetch">
                                <div class="row align-items-center">
                                    <div class="col-md-auto">
                                        <div class="form-group row align-items-center">
                                            <div class="col-1 text-bold">기간</div>
                                            <div class="col-10 d-flex align-items-center">
                                                <div class="col">
                                                    <div class="input-group"  data-target-input="nearest">
                                                        <input type="text" class="form-control " id="startDate" v-model="startDate"/>
                                                        <div class="input-group-append" >
                                                            <div class="input-group-text"><i class="far fa-calendar-alt"></i></div>
                                                        </div>
                                                    </div>
                                                </div>
                                                ~
                                                <div class="col">
                                                    <div class="input-group" data-target-input="nearest">
                                                        <input type="text" class="form-control " id="endDate" v-model="endDate"/>
                                                        <div class="input-group-append" data-target="#endDate" data-toggle="datetimepicker">
                                                            <div class="input-group-text"><i class="far fa-calendar-alt"></i></div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6 d-flex align-items-center">
                                        <div class="form-group">
                                            <div class="btn-group" role="group">
                                                <button type="button" class="btn btn-outline-primary" @click="setRange(1)">1개월</button>
                                                <button type="button" class="btn btn-outline-primary" @click="setRange(3)">3개월</button>
                                                <button type="button" class="btn btn-outline-primary" @click="setRange(6)">6개월</button>
                                                <button type="button" class="btn btn-outline-primary" @click="setRange(12)">1년</button>
                                            </div>
                                        </div>
                                        <div class="form-group ml-3">
                                            <div class="input-group-append">
                                                <button class="btn btn-primary" type="submit">검색</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header d-flex flex-wrap justify-content-between">
                            <h3 class="card-title col-auto">사용자 접속 현황</h3>
                        </div>
                        <div class="card-body p-0">
                            <div id="chart" class="chart-wrap"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>

<script>

    function setChart(data){

        am4core.useTheme(am4themes_animated);

        var chart = am4core.create("chart", am4charts.XYChart);

        chart.data = data;

        // Create axes
        var dateAxis = chart.xAxes.push(new am4charts.DateAxis());
        dateAxis.renderer.minGridDistance = 50;

        // Create series
        function createAxisAndSeries(field, name, opposite, bullet) {
            var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
            if(chart.yAxes.indexOf(valueAxis) != 0){
                valueAxis.syncWithAxis = chart.yAxes.getIndex(0);
            }

            var series = chart.series.push(new am4charts.LineSeries());
            series.dataFields.valueY = field;
            series.dataFields.dateX = "createdDate";
            series.strokeWidth = 2;
            series.yAxis = valueAxis;
            series.name = name;
            series.tooltipText = "{name}: [bold]{valueY}[/]";
            series.tensionX = 0.9;
            series.fillOpacity = 0.1;
            series.showOnInit = true;

            var colorSet = new am4core.ColorSet();
            colorSet.list = ["#07b1ed", "#f8a139", "#f7941d", "#33cc99"].map(function(color) {
                return new am4core.color(color);
            });

            series.colors = colorSet;

            switch(bullet) {
                case "triangle":
                    var bullet = series.bullets.push(new am4charts.Bullet());
                    bullet.width = 12;
                    bullet.height = 12;
                    bullet.horizontalCenter = "middle";
                    bullet.verticalCenter = "middle";

                    var triangle = bullet.createChild(am4core.Triangle);
                    triangle.strokeWidth = 2;
                    triangle.direction = "top";
                    triangle.fill = am4core.color("#fff");
                    triangle.width = 12;
                    triangle.height = 12;
                    break;
                case "rectangle":
                    var bullet = series.bullets.push(new am4charts.Bullet());
                    bullet.width = 10;
                    bullet.height = 10;
                    bullet.horizontalCenter = "middle";
                    bullet.verticalCenter = "middle";

                    var rectangle = bullet.createChild(am4core.Rectangle);
                    rectangle.strokeWidth = 2;
                    rectangle.fill = am4core.color("#fff");
                    rectangle.width = 10;
                    rectangle.height = 10;
                    break;
                default:
                    var bullet = series.bullets.push(new am4charts.CircleBullet());
                    bullet.circle.fill = am4core.color("#fff");
                    bullet.circle.strokeWidth = 2;
                    break;
            }

            valueAxis.renderer.line.strokeOpacity = 1;
            valueAxis.renderer.line.strokeWidth = 2;
            valueAxis.renderer.line.stroke = series.stroke;
            valueAxis.renderer.labels.template.fill = series.stroke;
            valueAxis.renderer.opposite = opposite;
        }

        /*var color1 = am4core.color("#f8a139");
        var color2 = am4core.color("#07b1ed");*/
        var color1 = am4core.color("#6579ef");
        var color2 = am4core.color("#07b1ed");

        chart.colors.list = [
            color1,
            color2
        ];

        createAxisAndSeries("visitCnt", "방문자", false, "circle");

        // Add legend
        chart.legend = new am4charts.Legend();

        // Add cursor
        chart.cursor = new am4charts.XYCursor();
    }

</script>

<script>

    // Root
    var vm = new Vue({
        el: '#vue-app',
        mounted: function () {

            var self = this;

            $('#startDate').datetimepicker({
                format:'Y-m-d',
                timepicker: false,
                onChangeDateTime:function(dp,$input){
                    self.startDate = $input.val();
                }
            });

            $('#endDate').datetimepicker({
                format:'Y-m-d',
                timepicker: false,
                onChangeDateTime:function(dp,$input){
                    self.endDate = $input.val();
                }
            });

            if (this.startDate == '')
                this.setRange(1);
            this.fetch();
        },
        data: {
            startDate: '${param.startDate}',
            endDate: '${param.endDate}',
        },
        watch: {

        },
        computed: {

        },
        methods: {
            fetch: function () {
                this.setChart();
            },
            setRange: function(months){
                this.startDate = moment().subtract(months, 'month').format('YYYY-MM-DD');
                this.endDate = moment().format('YYYY-MM-DD');
            },
            getSearch: function(){
                return '?startDate=' + this.startDate + '&endDate=' + this.endDate;
            },
            setChart(){
                axios.get(contextPath + "/admin/stats-visit/chart" + this.getSearch(), {data: {}}).then(function (data) {
                    setChart(data.data);
                }).catch(function (err) {
                    errorToastr("사용자 접속 현황 조회중 오류가 발생하였습니다.");
                });
            },
        }
    });
</script>