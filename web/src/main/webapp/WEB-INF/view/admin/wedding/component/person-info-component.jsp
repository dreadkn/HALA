<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<%@ include file="/WEB-INF/view/common/dropzone.jsp" %>

<script type="text/x-template" id="person-info-component">
    <form>

        <div class="form-row">
            <div class="form-group col-md-8">
                <label>내용</label>
                <textarea name="content" class="w-100 form-control" rows="10" v-model="person.content"></textarea>
                <div id="contentError" class="invalid-feedback"></div>
            </div>
        </div>
    </form>

</script>

<script>


    var personInfoComponent = {
        template: '#person-info-component',
        props : ['wedding'],
        mounted: function () {


        },
        watch: {
            wedding: function(){
                this.person.content = this.wedding.content;
            }
        },
        computed: {

        },
        data: function () {
            return {
                person: {
                    content: '',
                },
                acceptedFiles : 'image/*',
                isFirst : true,
                currentTab : 0,
                tabs : ['기본정보']
            }
        },
        methods: {

        }
    }
</script>
