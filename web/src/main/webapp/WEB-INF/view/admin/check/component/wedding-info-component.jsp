<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<%@ include file="/WEB-INF/view/common/dropzone.jsp" %>
<jsp:include page="death-info-component.jsp"/>
<jsp:include page="person-info-component.jsp"/>

<script type="text/x-template" id="wedding-info-component">
    <form>

        <div class="form-row">
            <div class="form-group col-md-12 ">
                <div class="row align-items-center">
                    <div class="col-12">
                        <label class="mw-2"><small class="text-danger">*</small>공개여부</label>
                    </div>
                    <div class="col-12">
                        <label class="radio-button-wrap mx-3">
                            <input type="radio" id="isPublicY" name="isPublic" :value="true" v-model="wedding.isPublic">
                            <span class="radio-button"></span>
                        </label>
                        <label for="isPublicY" class="mr-5">공개</label>
                        <label class="radio-button-wrap mx-3">
                            <input type="radio" id="isPublicN" name="isPublic" :value="false" v-model="wedding.isPublic">
                            <span class="radio-button"></span>
                        </label>
                        <label for="isPublicN">비공개</label>
                    </div>
                </div>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group col-md-4">
                <label>구분</label>
                <select class="form-select" v-model="wedding.dtype">
                    <tags:enum-select code="CongratulationsType"></tags:enum-select>
                </select>
                <div id="dtypeError" class="invalid-feedback"></div>
            </div>
        </div>
        <div class="form-row">
            <div class="form-group col-md-8">
                <label>제목</label>
                <input type="text" class="form-control" id="title" name="title" v-model="wedding.title"  disabled >
                <div id="titleError" class="invalid-feedback"></div>
            </div>
        </div>
        <form v-if="wedding.dtype == 'WEDDING'">
            <div class="form-row">
                <div class="form-group col-md-8">
                    <label>신랑</label>
                    <input type="text" class="form-control" name="groom" v-model="wedding.groom" disabled  >
                    <div id="groomError" class="invalid-feedback"></div>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group col-md-8">
                    <label>신랑</label>
                    <input type="text" class="form-control" name="groomJob" v-model="wedding.groomJob" disabled  >
                    <div id="groomJobError" class="invalid-feedback"></div>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group col-md-8">
                    <label>신랑 부</label>
                    <input type="text" class="form-control" name="groomFather" v-model="wedding.groomFather"  disabled >
                    <div id="groomFatherError" class="invalid-feedback"></div>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group col-md-8">
                    <label>신랑 모</label>
                    <input type="text" class="form-control" name="groomMother" v-model="wedding.groomMother" disabled   >
                    <div id="groomMotherError" class="invalid-feedback"></div>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group col-md-8">
                    <label>신부</label>
                    <input type="text" class="form-control" name="bride" v-model="wedding.bride" disabled  >
                    <div id="brideError" class="invalid-feedback"></div>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group col-md-8">
                    <label>신부 직업</label>
                    <input type="text" class="form-control" name="brideJob" v-model="wedding.brideJob"  disabled >
                    <div id="brideJobError" class="invalid-feedback"></div>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group col-md-8">
                    <label>신부 부</label>
                    <input type="text" class="form-control" name="brideFather" v-model="wedding.brideFather" disabled  >
                    <div id="brideFatherError" class="invalid-feedback"></div>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group col-md-8">
                    <label>신부 모</label>
                    <input type="text" class="form-control" id="brideMother" name="brideMother" v-model="wedding.brideMother" disabled  >
                    <div id="brideMotherError" class="invalid-feedback"></div>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group col-md-8">
                    <label>일시</label>
                    <input type="text" class="form-control" name="weddingDate" v-model="wedding.weddingDate" disabled  >
                    <div id="weddingDateError" class="invalid-feedback"></div>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group col-md-8">
                    <label>장소</label>
                    <input type="text" class="form-control" name="place" v-model="wedding.place" disabled  >
                    <div id="placeError" class="invalid-feedback"></div>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group col-md-8">
                    <label>피로연 일시</label>
                    <input type="text" class="form-control" name="partyDate" v-model="wedding.partyDate" disabled   >
                    <div id="partyDateError" class="invalid-feedback"></div>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group col-md-8">
                    <label>피로연 장소</label>
                    <input type="text" class="form-control" name="partyPlace" v-model="wedding.partyPlace" disabled  >
                    <div id="partyPlaceError" class="invalid-feedback"></div>
                </div>
            </div>
        </form>

        <death-info-component ref="content" :wedding="wedding" v-show="wedding.dtype == 'DEATH'" ></death-info-component>
        <person-info-component ref="content" :wedding="wedding" v-show="wedding.dtype == 'PERSON'" ></person-info-component>

        <div class="form-row">
            <div class="form-group col-md-8">
                <label>홈페이지링크</label>
                <input type="text" class="form-control" id="homepageUrl" name="homepageUrl" v-model="wedding.homepageUrl"   >
                <div id="homepageUrlError" class="invalid-feedback"></div>
            </div>
            <div class="form-group col-md-8">
                <label>유튜브링크</label>
                <input type="text" class="form-control" id="youtubeUrl" name="youtubeUrl" v-model="wedding.youtubeUrl"   >
                <div id="youtubeUrlError" class="invalid-feedback"></div>
            </div>
        </div>


        <div class="form-row">
            <div class="form-group col-md-12">
                <legend class="col-form-label pt-0 font-weight-bold">이미지</legend>
                <div class="input-group mb-3">
                    <dropzone-component ref="dropzone" :files="wedding.files" :delete="false" :max-files="10" :accepted-files="acceptedFiles"></dropzone-component>
                </div>
            </div>
        </div>
    </form>

</script>

<script>


    var weddingInfoComponent = {
        template: '#wedding-info-component',
        props : ['id'],
        components: {
            'person-info-component': personInfoComponent,
            'death-info-component': deathInfoComponent,
        },
        mounted: function () {
            this.fetch();
        },
        watch: {
            wedding: function(){
                if(this.isFirst)
                {
                    this.wedding.dtype = this.wedding.dtype.code;
                    this.isFirst = false;
                }
            }
        },
        computed: {

        },
        data: function () {
            return {
                wedding: {
                    isPublic: true,
                    title: '',
                    dtype: 'WEDDING',
                    content: '',
                    homepageUrl: '',
                    youtubeUrl: '',
                    readCount: 0,
                    files: [],
                },
                acceptedFiles : 'image/*',
                isFirst : true,
                currentTab : 0,
                tabs : ['기본정보']
            }
        },
        methods: {
            fetch: function () {
                var self = this;
                axios.get(contextPath + "/admin/wedding/detail/" + self.id, {data: {}}).then(function (data) {
                    self.wedding = data.data;
                }).catch(function (err) {
                });
            }

        }
    }
</script>
