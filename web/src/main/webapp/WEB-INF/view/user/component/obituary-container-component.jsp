<%--
  Created by IntelliJ IDEA.
  User: jskim
  Date: 2022/09/14
  Time: 10:18 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>

<script type="text/x-template" id="obituary-container-component">
    <a :href="'/familyEvent/obituary/' + obituary.id" class="obituary-article d-block">
        <div class="obituary-contents d-flex justify-content-center align-items-center flex-column overflow-hidden">
            <h6 class="category font-size-25 fw-bold">부고</h6>
            <h6 class="title font-size-20 fw-bold my-5">{{obituary.deceased}}씨 {{obituary.deceasedJob ? '(' + obituary.deceasedJob + ')' : ''}}별세</h6>
            <ul class="obituary-location w-100 px-4 text-left">
                <li class="color-gray">일포 : {{obituary.illpho}}</li>
                <li class="color-gray">발인일시 : {{obituary.outDate}}</li>
                <li class="color-gray">발인장소 : {{obituary.place}}</li>
                <li class="color-gray">장지 : {{obituary.cemetery}}</li>
            </ul>

            <ul class="obituary-family w-100 px-4 text-left">
                <li v-for="content in getStringToArray(obituary.content)">{{content}}</li>
            </ul>
        </div>
    </a>
</script>


<script>
    var obituaryContainerComponent = {
        template: '#obituary-container-component',
        mounted: function () {},
        watch: {},
        computed: {},
        props: ["obituary"],
        data: function () {
            return {
            }
        },
        methods: {
            getStringToArray : function(str){
                str = this.lineToComma(str);
                return str.split(',');
            },
            lineToComma : function(html){
                html = html.replace(/\r\n/gi, ',');
                html = html.replace(/\\n/gi, ',');
                html = html.replace(/\n/gi, ',');
                return html
            },
        }
    }
</script>
