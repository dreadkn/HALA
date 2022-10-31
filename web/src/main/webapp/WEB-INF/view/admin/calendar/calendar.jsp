<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<jsp:include page="/WEB-INF/view/common/vue-datatable-pagination.jsp"/>

<link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/@mdi/font@6.x/css/materialdesignicons.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/vuetify@2.x/dist/vuetify.min.css" rel="stylesheet">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">
<script src="https://cdn.jsdelivr.net/npm/vue@2.x/dist/vue.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vuetify@2.x/dist/vuetify.js"></script>

<div id="vue-app" class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h4 class="m-0 text-dark">캘린더 일정관리</h4>
                </div>
                <div class="d-none col-sm-6 d-md-block">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item active">캘린더 일정관리</li>
                    </ol>
                </div>
            </div>
        </div>
    </div>
    <!-- /.content-header -->

    <!-- Main content -->
    <div class="content">
        <div class="container-fluid">
            <div class="col-12">
                <div class="row mt-5 mb-12">
                    <div class="col-auto">
                        https://vuetifyjs.com/en/components/calendars/
                        API : https://vuetifyjs.com/en/api/v-calendar-monthly/#props

                    </div>
                </div>
            </div>
            <div class="row">

            </div>
            <div class="row">
                <div class="col-12">

                    <div id="app">
                        <v-app id="inspire">
                            <v-row class="fill-height">
                                <v-col>
                                    <v-sheet height="64">
                                        <v-toolbar flat>
                                            <v-btn outlined class="mr-4" color="grey darken-2" @click="setToday">
                                                Today
                                            </v-btn>
                                            <v-btn fab text small color="grey darken-2" @click="prev">
                                                <v-icon small>
                                                    mdi-chevron-left
                                                </v-icon>
                                            </v-btn>
                                            <v-btn fab text small color="grey darken-2" @click="next">
                                                <v-icon small>
                                                    mdi-chevron-right
                                                </v-icon>
                                            </v-btn>
                                            <v-toolbar-title v-if="$refs.calendar">
                                                {{ $refs.calendar.title }}
                                            </v-toolbar-title>
                                            <v-spacer></v-spacer>
                                            <v-btn outlined class="mr-4" color="grey darken-2" @click="setMonth">
                                                Month
                                            </v-btn>
                                            <v-btn outlined class="mr-4" color="grey darken-2" @click="setWeek">
                                                Week
                                            </v-btn>
                                            <v-btn outlined class="mr-4" color="grey darken-2" @click="setDay">
                                                Day
                                            </v-btn>
                                            <v-menu bottom right>
                                                <template v-slot:activator="{ on, attrs }">
                                                    <v-btn outlined color="grey darken-2" v-bind="attrs" v-on="on">
                                                        <span>{{ typeToLabel[type] }}</span>
                                                        <v-icon right>
                                                            mdi-menu-down
                                                        </v-icon>
                                                    </v-btn>
                                                </template>
                                                <v-list>
                                                    <v-list-item @click="type = 'day'">
                                                        <v-list-item-title>Day</v-list-item-title>
                                                    </v-list-item>
                                                    <v-list-item @click="type = 'week'">
                                                        <v-list-item-title>Week</v-list-item-title>
                                                    </v-list-item>
                                                    <v-list-item @click="type = 'month'">
                                                        <v-list-item-title>Month</v-list-item-title>
                                                    </v-list-item>
<%--                                                    <v-list-item @click="type = '4day'">--%>
<%--                                                        <v-list-item-title>4 days</v-list-item-title>--%>
<%--                                                    </v-list-item>--%>
                                                </v-list>
                                            </v-menu>
                                        </v-toolbar>
                                    </v-sheet>
                                    <v-sheet height="900">
                                        <v-calendar
                                                ref="calendar"
                                                v-model="focus"
                                                color="primary"
                                                :events="events"
                                                :event-color="getEventColor"
                                                :type="type"
                                                :show-week="true"
                                                @click:event="showEvent"
                                                @click:more="viewDay"
                                                @click:date="viewDay"
                                                @change="updateRange"
                                                @mousedown:event="startDrag"
                                                @mousedown:day="moveStartDay"
                                                @mousemove:day="mouseMoveDay"
                                                @mouseup:day="endDrag"
                                                @mousedown:time="moveStartTime"
                                                @mousemove:time="mouseMove"
                                                @mouseup:time="endDrag"
                                                @mouseleave.native="cancelDrag"
                                        ></v-calendar>
                                        <v-menu v-model="selectedOpen" :close-on-content-click="false" :activator="selectedElement" offset-x>
                                            <v-card color="grey lighten-4" min-width="350px" flat>
                                                <v-toolbar :color="selectedEvent.color" dark>
                                                    <v-btn icon>
                                                        <v-icon>mdi-pencil</v-icon>
                                                    </v-btn>
                                                    <v-toolbar-title v-html="selectedEvent.name"></v-toolbar-title>
                                                    <v-spacer></v-spacer>
                                                    <v-btn icon>
                                                        <v-icon>mdi-heart</v-icon>
                                                    </v-btn>
                                                    <v-btn icon>
                                                        <v-icon>mdi-dots-vertical</v-icon>
                                                    </v-btn>
                                                </v-toolbar>
                                                <v-card-text>
                                                    <span v-html="selectedEvent.details"></span>
                                                    <span v-html="selectedEvent.start"></span>
                                                    <span v-html="selectedEvent.end"></span>
                                                </v-card-text>
                                                <v-row>
                                                    <v-col cols="4" sm="2" md="3">
                                                        <input type="text" class="form-control" name="name" v-model="selectedEvent.name" placeholder="일정명">
                                                    </v-col>
                                                </v-row>
                                                <v-row>
                                                    <v-col cols="1" md="3">
                                                        시작일시
                                                    </v-col>
                                                    <v-col cols="12" sm="6" md="4">

                                                        <v-menu v-model="startDateVisible" :close-on-content-click="false" :nudge-right="40" transition="scale-transition" offset-y min-width="auto">
                                                            <template v-slot:activator="{ on, attrs }">
                                                                <v-text-field v-model="startDate" label="일자 선택" prepend-icon="mdi-calendar" readonly v-bind="attrs" v-on="on"></v-text-field>
                                                            </template>
                                                            <v-date-picker v-model="startDate" @input="startDateVisible = false"></v-date-picker>
                                                        </v-menu>
                                                    </v-col>
                                                    <v-col cols="11" sm="5" v-if="selectedEvent.timed">
                                                        <v-menu ref="startTime" :close-on-content-click="false" :nudge-right="40" :return-value.sync="startTime" transition="scale-transition"
                                                                offset-y max-width="290px" min-width="290px">
                                                            <template v-slot:activator="{ on, attrs }">
                                                                <v-text-field v-model="startTime" label="시간 선택" prepend-icon="mdi-clock-time-four-outline" readonly v-bind="attrs" v-on="on"></v-text-field>
                                                            </template>
                                                            <v-time-picker v-model="startTime" full-width @click:minute="$refs.startTime.save(startTime)"></v-time-picker>
                                                        </v-menu>
                                                    </v-col>
                                                </v-row>
                                                <v-row>
                                                    <v-col cols="1" md="3">
                                                        종료일시
                                                    </v-col>
                                                    <v-col cols="12" sm="6" md="4">

                                                        <v-menu v-model="endDateVisible" :close-on-content-click="false" :nudge-right="40" transition="scale-transition" offset-y min-width="auto">
                                                            <template v-slot:activator="{ on, attrs }">
                                                                <v-text-field v-model="endDate" label="일자 선택" prepend-icon="mdi-calendar" readonly v-bind="attrs" v-on="on" ></v-text-field>
                                                            </template>
                                                            <v-date-picker v-model="endDate" @input="endDateVisible = false"></v-date-picker>
                                                        </v-menu>
                                                    </v-col>
                                                    <v-col cols="11" sm="5" v-if="selectedEvent.timed">
                                                        <v-menu ref="endTime" :close-on-content-click="false" :nudge-right="40" :return-value.sync="endTime" transition="scale-transition"
                                                                offset-y max-width="290px" min-width="290px">
                                                            <template v-slot:activator="{ on, attrs }">
                                                                <v-text-field v-model="endTime" label="시간 선택" prepend-icon="mdi-clock-time-four-outline" readonly v-bind="attrs" v-on="on"></v-text-field>
                                                            </template>
                                                            <v-time-picker v-model="endTime" full-width @click:minute="$refs.endTime.save(endTime)"></v-time-picker>
                                                        </v-menu>
                                                    </v-col>
                                                </v-row>
                                                <v-row>
                                                    <v-col cols="1" md="3">
                                                        시간 설정
                                                    </v-col>
                                                    <v-col cols="12" sm="6" md="4">

                                                        <input type="checkbox" name="timed" v-model="selectedEvent.timed" value="1"/>

                                                    </v-col>
                                                </v-row>
                                                <v-card-actions>
                                                    <v-btn text color="secondary" @click="selectedOpen = false">Cancel</v-btn>
                                                    <v-btn text color="secondary" @click="submitEvent">Ok</v-btn>
                                                </v-card-actions>
                                            </v-card>
                                        </v-menu>
                                    </v-sheet>
                                </v-col>
                            </v-row>
                        </v-app>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>

<script>
    var dataTable;
    // Root
    var vm = new Vue({
        el: '#vue-app',
        vuetify: new Vuetify(),
        data: () => ({
            focus: '',
            type: 'month',
            typeToLabel: {
                month: 'Month',
                week: 'Week',
                day: 'Day',
                '4day': '4 Days',
            },
            selectedEvent: {
                id: null,

            },
            selectedElement: null,
            selectedOpen: false,
            events: [],
            colors: ['blue', 'indigo', 'deep-purple', 'cyan', 'green', 'orange', 'grey darken-1'],
            names: ['Meeting', 'Holiday', 'PTO', 'Travel', 'Event', 'Birthday', 'Conference', 'Party'],
            dragEvent: null,
            dragStart: null,
            createEvent: null,
            createStart: null,
            extendOriginal: null,
            selectStartDay: null,
            selectEndDay: null,
            selectEndDayGap: null,
            date: (new Date(Date.now() - (new Date()).getTimezoneOffset() * 60000)).toISOString().substr(0, 10),
            time: null,
            startDateVisible: false,
            endDateVisible: false,
            startTimeVisible: false,
            modal2: false,
            startDate: null,
            startTime: null,
            endDate: null,
            endTime : null,
            rangeStart: null,
            rangeEnd: null,


        }),
        watch: {
            /**
             * 스케줄 관리 팝업 내 일자/시간 변경시 업데이트 처리
             */
            startDate: function () {
                // console.log('change startDate');
                if (this.selectedEvent != null) {
                    var gap = this.selectedEvent.end.valueOf() - this.selectedEvent.start.getMilliseconds();

                    const start = new Date(this.stringToDate(this.startDate, this.startTime));
                    const end = new Date(start.valueOf() + gap);
                    this.selectedEvent.start = new Date(start);
                    // this.selectedEvent.end = new Date(end);

                    this.endDate = this.toDateString(new Date(end));
                    this.endTime = this.toTimeString(new Date(end));
                }
            },
            startTime: function () {
                // console.log('change startTime');
                if (this.selectedEvent != null) {
                    var gap = this.selectedEvent.end - this.selectedEvent.start;

                    const start = new Date(this.stringToDate(this.startDate, this.startTime));

                    const end = new Date(start.valueOf() + gap);
                    this.selectedEvent.start = new Date(start);
                    // this.selectedEvent.end = new Date(end);

                    console.log(this.toDateString(new Date(end)));
                    this.endDate = this.toDateString(new Date(end));
                    this.endTime = this.toTimeString(new Date(end));
                }
            },
            endDate: function () {
                // console.log('change endDate');
                if (this.selectedEvent != null) {
                    const end = new Date(this.stringToDate(this.endDate, this.endTime));
                    this.selectedEvent.end = new Date(end);
                    console.log(this.selectedEvent.end);
                }
            },
            endTime: function () {
                // console.log('change endTime');
                if (this.selectedEvent != null) {
                    const end = new Date(this.stringToDate(this.endDate, this.endTime));
                    this.selectedEvent.end = new Date(end);
                    console.log(this.selectedEvent.end);
                }
            }
        },
        mounted () {

        },
        methods: {
            /** 스케줄 생성/수정 완료 처리*/
            submitEvent() {
                // locale 무시
                this.selectedEvent.start = new Date(this.selectedEvent.start - this.selectedEvent.start.getTimezoneOffset() * 60000);
                this.selectedEvent.end = new Date(this.selectedEvent.end - this.selectedEvent.end.getTimezoneOffset() * 60000);

                if (this.selectedEvent.id == null) {
                    this.add();
                } else {
                    this.update();
                }

                this.selectedOpen = false;
            },
            add: function () {
                var self = this;
                axios.post("/admin/mng/calendar", self.selectedEvent).then(function (res) {
                    self.fetchSchedule();
                    alertRegistered();
                    setTimeout(function(){

                    },1500);
                }).catch(function (err) {
                    displayErrors(err);
                });
            },
            update: function () {
                var self = this;
                axios.put("/admin/mng/calendar/" + self.selectedEvent.id, self.selectedEvent).then(function (res) {
                    self.fetchSchedule();
                    alertUpdated();
                }).catch(function (err) {
                    errorToastr(err);
                });
            },

            viewDay ({ date }) {
                this.focus = date
                this.type = 'day'
            },
            setMonth() {
                this.type = 'month';
            },
            setWeek() {
                this.type = 'week';
            },
            setDay() {
                this.type = 'day';
            },
            getEventColor (event) {
                return event.color
            },
            setToday () {
                this.focus = ''
            },
            prev () {
                this.$refs.calendar.prev()
            },
            next () {
                this.$refs.calendar.next()
            },
            /** 스케줄 선택시 팝업 호출 */
            showEvent ({ nativeEvent, event }) {
                var self = this;
                const open = () => {

                    console.log('open');
                    var start = new Date(event.start);
                    var end = new Date(event.end);



                    this.selectedEvent = {
                        id: event.id,
                        name: event.name,
                        start: new Date(event.start),
                        end: new Date(event.end),
                        color: event.color,
                        timed: event.timed,
                    }
                    this.startDate = self.toDateString(start);
                    this.startTime = self.toTimeString(start);

                    this.endDate = self.toDateString(end);
                    this.endTime = self.toTimeString(end);

                    this.selectedElement = nativeEvent.target
                    requestAnimationFrame(() => requestAnimationFrame(() => this.selectedOpen = true))
                }

                if (this.selectedOpen) {
                    this.selectedOpen = false
                    requestAnimationFrame(() => requestAnimationFrame(() => open()))
                } else {
                    open()
                }

                nativeEvent.stopPropagation()
            },
            /** 캘린더 범위 변경 이벤트 */
            updateRange ({ start, end }) {

                console.log(start.date);
                console.log(end.date);
                this.rangeStart = start.date;
                this.rangeEnd = end.date;
                this.fetchSchedule();

            },
            fetchSchedule () {
                var self = this;
                axios.get(contextPath + "/admin/mng/calendar/schedules?startDate=" + self.rangeStart + "&endDate=" + self.rangeEnd, {data: {

                    }}).then(function (data) {
                    console.log(data);
                    self.events = data.data;

                }).catch(function (err) {
                    errorToastr("스케쥴 조회중 오류가 발생하였습니다.");
                    setTimeout(function () {

                    }, 1500)
                });
            },
            rnd (a, b) {
                return Math.floor((b - a + 1) * Math.random()) + a;
            },
            startDrag ({ event, timed }) {
                if (event) {
                    this.dragEvent = event
                    this.dragTime = null
                    this.extendOriginal = null
                }
            },
            /** 월간 캘린더 스케줄 이동/신규 생성 이벤트 시작 */
            moveStartDay (tms) {
                if (this.selectedOpen)
                    return;

                if (this.dragEvent) {
                    this.selectStartDay = new Date(this.dragEvent.start);
                    this.selectEndDay = new Date(this.dragEvent.end);
                    this.selectEndDayGap = this.selectEndDay - this.selectStartDay;
                } else {
                    const mouse = this.toDateTime(tms, null);
                    this.createStart = this.roundTime(mouse);
                    this.selectStartDay = this.createStart;
                    this.createEvent = {
                        id: null,
                        name: ``,
                        color: this.rndElement(this.colors),
                        start: new Date(this.createStart),
                        end: new Date(this.createStart),
                        timed: false,
                    }
                    this.events.push(this.createEvent)
                }
            },
            /** 월간 캘린더 스케줄 이동/신규 생성 이벤트 이동중 위치 업데이트 */
            mouseMoveDay (tms) {

                if (this.dragEvent) {
                    const newStart = this.toDateTime(tms, this.selectStartDay);
                    const newEnd = newStart + this.selectEndDayGap;

                    this.dragEvent.start = new Date(newStart);
                    this.dragEvent.end = new Date(newEnd);

                } else if (this.createEvent && this.createStart !== null) {

                    const newEnd = this.toDateTime(tms, null);

                    this.createEvent.start = new Date(this.selectStartDay);
                    this.createEvent.end = new Date(newEnd);
                }
            },
            /** 주간/일일 캘린더 스케줄 이동/신규 생성 이벤트 시작 */
            moveStartTime (tms) {
                if (this.selectedOpen)
                    return;

                const mouse = this.toTimeTms(tms)

                if (this.dragEvent && this.dragTime === null) {

                    const start = new Date(this.dragEvent.start);

                    console.log(start);
                    this.dragTime = mouse - start
                } else {
                    this.createStart = this.roundTime(mouse)

                    this.createEvent = {
                        id: null,
                        name: ``,
                        color: this.rndElement(this.colors),
                        start: new Date(this.createStart),
                        end: new Date(this.createStart),
                        timed: true,
                    }

                    this.events.push(this.createEvent)
                }
            },
            /** 주간/일일 캘린더 스케줄 이동/신규 생성 이동중 위치 업데이트 */
            mouseMove (tms) {
                const mouse = this.toTimeTms(tms);

                if (this.dragEvent && this.dragTime !== null) {
                    const start = new Date(this.dragEvent.start);
                    const end = new Date(this.dragEvent.end);
                    const duration = end - start
                    const newStartTime = mouse - this.dragTime
                    const newStart = this.roundTime(newStartTime)
                    const newEnd = newStart + duration

                    this.dragEvent.start = new Date(newStart);
                    this.dragEvent.end = new Date(newEnd);
                } else if (this.createEvent && this.createStart !== null) {
                    const mouseRounded = this.roundTime(mouse, false)
                    const min = Math.min(mouseRounded, this.createStart)
                    const max = Math.max(mouseRounded, this.createStart)

                    this.createEvent.start = new Date(min);
                    this.createEvent.end = new Date(max);
                }
            },
            /** 스케줄 이동완료 처리 */
            endDrag () {
                /** 신규 생성인 경우 팝업 출력*/
                if (this.createEvent != null) {
                    this.startDate = this.toDateString(this.createEvent.start);
                    this.startTime = this.toTimeString(this.createEvent.start);

                    this.endDate = this.toDateString(this.createEvent.end);
                    this.endTime = this.toTimeString(this.createEvent.end);

                    this.events.pop();
                    this.selectedEvent = this.createEvent;
                    this.selectedOpen = true;
                }
                this.dragTime = null
                this.dragEvent = null
                this.createEvent = null
                this.createStart = null
                this.extendOriginal = null
                this.selectStartDay = null
                this.selectEndDay = null

            },
            cancelDrag () {
                this.createEvent = null
                this.createStart = null
                this.dragTime = null
                this.dragEvent = null
            },
            roundTime (time, down = true) {
                const roundTo = 15 // minutes
                const roundDownTime = roundTo * 60 * 1000

                return down
                    ? time - time % roundDownTime
                    : time + (roundDownTime - (time % roundDownTime))
            },
            toTimeTms (tms) {
                return new Date(tms.year, tms.month - 1, tms.day, tms.hour, tms.minute).getTime()
            },
            toDateTime (tms, date) {
                if (this.dragEvent != null && date != null) {
                    return new Date(tms.year, tms.month - 1, tms.day, date.getHours(), date.getMinutes()).getTime()
                } else {
                    return new Date(tms.year, tms.month - 1, tms.day, tms.hour, tms.minute).getTime()
                }

            },
            rndElement (arr) {
                return arr[this.rnd(0, arr.length - 1)]
            },
            toDateTimeString(date) {
                return this.toDateString(date) + ' ' + this.toTimeString(date);
            },
            toDateString(date) {
                var month = date.getMonth() + 1;
                if (month < 10) {
                    month = '0' + month;
                }
                var day = date.getDate();
                if (day < 10) {
                    day = '0' + day;
                }
                return date.getFullYear() + '-' + month + '-' + day;
            },
            toTimeString(date) {
                var hour = date.getHours();
                if (hour < 10) {
                    hour = '0' + hour;
                }
                var minute = date.getMinutes();
                if (minute < 10) {
                    minute = '0' + minute;
                }
                return hour + ':' + minute;
            },
            stringToDate (day, time) {

                return new Date(day + ' ' + time).getTime();
            },
        },
    });

</script>
