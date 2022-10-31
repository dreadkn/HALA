<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<%@ include file="/WEB-INF/view/common/dropzone.jsp" %>

<script type="text/x-template" id="death-info-component">
    <form>

        <div class="form-row">
            <div class="form-group col-md-8">
                <label>고인</label>
                <input type="text" class="form-control" name="deceased" v-model="death.deceased" disabled >
                <div id="deceasedError" class="invalid-feedback"></div>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group col-md-8">
                <label>고인 직업</label>
                <input type="text" class="form-control" name="deceasedJob" v-model="death.deceasedJob" disabled >
                <div id="deceasedJobError" class="invalid-feedback"></div>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group col-md-8">
                <label>일포</label>
                <input type="text" class="form-control" name="illpho" v-model="death.illpho" disabled >
                <div id="illphoError" class="invalid-feedback"></div>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group col-md-8">
                <label>발인일시</label>
                <input type="text" class="form-control" name="outDate" v-model="death.outDate" disabled >
                <div id="outDateError" class="invalid-feedback"></div>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group col-md-8">
                <label>발인장소</label>
                <input type="text" class="form-control" name="place" v-model="death.place" disabled >
                <div id="placeError" class="invalid-feedback"></div>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group col-md-8">
                <label>장지</label>
                <input type="text" class="form-control" name="cemetery" v-model="death.cemetery" disabled >
                <div id="cemeteryError" class="invalid-feedback"></div>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group col-md-8">
                <label>내용</label>
                <textarea name="content" class="w-100 form-control" rows="10" v-model="death.content" disabled></textarea>
                <div id="contentError" class="invalid-feedback"></div>
            </div>
        </div>

    </form>

</script>

<script>


    var deathInfoComponent = {
        template: '#death-info-component',
        props : ['wedding'],
        mounted: function () {

        },
        watch: {
            wedding: function(){
                this.death.deceased = this.wedding.deceased;
                this.death.deceasedJob = this.wedding.deceasedJob;
                this.death.illpho = this.wedding.illpho;
                this.death.outDate = this.wedding.outDate;
                this.death.place = this.wedding.place;
                this.death.cemetery = this.wedding.cemetery;
                this.death.content = this.wedding.content;
            }
        },
        computed: {

        },
        data: function () {
            return {
                death: {
                    deceased: '',
                    illpho: '',
                    outDate: '',
                    place: '',
                    cemetery: '',
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
