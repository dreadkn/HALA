<%--
  Created by IntelliJ IDEA.
  User: jskim
  Date: 2022/09/14
  Time: 10:18 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>

<script type="text/x-template" id="main-personnel-component">
    <a :href="'/' + personnel.link" class="d-flex justify-content-between align-items-center py-4">
        <div class="">
            <span class="dept d-block color-deep-blue mb-1">{{personnel.title}}</span>
            <span class="name d-block fw-bold font-size-20">{{personnel.content.substr(0,12)}}...</span>
        </div>
        <img :src="getImage(personnel.fileId)" class="d-block rounded-circle border img-fluid" />
    </a>
</script>


<script>
    var mainPersonnelComponent = {
        template: '#main-personnel-component',
        mounted: function () {},
        watch: {},
        computed: {},
        props: ["personnel"],
        data: function () {
            return {
            }
        },
        methods: {
            getImage : function(id){
                return id == null ? '/resources/img/common/no-image.png' : '/files/' + id;
            },
        }
    }
</script>
