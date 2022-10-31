<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>

<script type="text/x-template" id="board-modal-form-component">
    <div class="modal fade" id="boardModal" tabindex="-1" role="dialog" aria-labelledby="boardModalLabel"
         aria-hidden="true">
        <div class="modal-dialog modal modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="boardModalLabel">게시판 {{isNew ? '등록' : '수정'}}</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="container-fluid">
                        <div class="form-row">
                            <div class="form-group col-12">
                                <legend class="col-form-label font-weight-bold">타입</legend>

                                <div v-for="(option, idx) in type" class="form-check-inline">
                                    <input class="form-check-input" type="radio" name="type" :id="'type'+idx"
                                           :value="option.code" v-model="board.type">
                                    <label class="form-check-label" :for="'type'+idx">{{option.value}}</label>
                                </div>
                                <div id="typeError" class="invalid-feedback"></div>
                            </div>
                            <div class="form-group col-12">
                                <label for="name">게시판명</label>
                                <input type="text" class="form-control" id="name" name="name" v-model="board.name" required>
                                <div id="nameError" class="invalid-feedback"></div>
                            </div>
                            <div class="form-group col-4">
                                <legend class="col-form-label font-weight-bold">비밀글 사용 여부</legend>
                                <div class="form-check-inline">
                                    <input class="form-check-input" type="radio" name="enableSecret" id="enableSecret0"
                                           :value="true" v-model.boolean="board.enableSecret">
                                    <label class="form-check-label" for="enableSecret0">사용</label>
                                </div>
                                <div class="form-check-inline">
                                    <input class="form-check-input" type="radio" name="enableSecret" id="enableSecret1"
                                           :value="false" v-model.boolean="board.enableSecret">
                                    <label class="form-check-label" for="enableSecret1">사용안함</label>
                                </div>
                                <div id="enableSecretError" class="invalid-feedback"></div>
                            </div>

                            <div class="form-group col-4">
                                <legend class="col-form-label font-weight-bold">답글 사용 여부</legend>
                                <div class="form-check-inline">
                                    <input class="form-check-input" type="radio" name="enableReply" id="enableReply0"
                                           :value="true" v-model.boolean="board.enableReply">
                                    <label class="form-check-label" for="enableReply0">사용</label>
                                </div>
                                <div class="form-check-inline">
                                    <input class="form-check-input" type="radio" name="enableReply" id="enableReply1"
                                           :value="false" v-model.boolean="board.enableReply">
                                    <label class="form-check-label" for="enableReply1">사용안함</label>
                                </div>
                                <div id="enableReplyError" class="invalid-feedback"></div>
                            </div>

                            <div class="form-group col-4">
                                <legend class="col-form-label font-weight-bold">댓글 사용 여부</legend>
                                <div class="form-check-inline">
                                    <input class="form-check-input" type="radio" name="enableComment" id="enableComment0"
                                           :value="true" v-model.boolean="board.enableComment">
                                    <label class="form-check-label" for="enableComment0">사용</label>
                                </div>
                                <div class="form-check-inline">
                                    <input class="form-check-input" type="radio" name="enableComment" id="enableComment1"
                                           :value="false" v-model.boolean="board.enableComment">
                                    <label class="form-check-label" for="enableComment1">사용안함</label>
                                </div>
                                <div id="enableCommentError" class="invalid-feedback"></div>
                            </div>

                            <div class="form-group col-4">
                                <legend class="col-form-label font-weight-bold">익명 사용자 글쓰기 여부</legend>
                                <div class="form-check-inline">
                                    <input class="form-check-input" type="radio" name="enableWriteAnonymousUser" id="enableWriteAnonymousUser0"
                                           :value="true" v-model.boolean="board.enableWriteAnonymousUser">
                                    <label class="form-check-label" for="enableWriteAnonymousUser0">사용</label>
                                </div>
                                <div class="form-check-inline">
                                    <input class="form-check-input" type="radio" name="enableWriteAnonymousUser" id="enableWriteAnonymousUser1"
                                           :value="false" v-model.boolean="board.enableWriteAnonymousUser">
                                    <label class="form-check-label" for="enableWriteAnonymousUser1">사용안함</label>
                                </div>
                                <div id="enableWriteAnonymousUserError" class="invalid-feedback"></div>
                            </div>

                            <div class="form-group col-4">
                                <legend class="col-form-label font-weight-bold">에디터 사용 여부</legend>
                                <div class="form-check-inline">
                                    <input class="form-check-input" type="radio" name="enableEditor" id="enableEditor0"
                                           :value="true" v-model.boolean="board.enableEditor">
                                    <label class="form-check-label" for="enableEditor0">사용</label>
                                </div>
                                <div class="form-check-inline">
                                    <input class="form-check-input" type="radio" name="enableEditor" id="enableEditor1"
                                           :value="false" v-model.boolean="board.enableEditor">
                                    <label class="form-check-label" for="enableEditor1">사용안함</label>
                                </div>
                                <div id="enableEditorError" class="invalid-feedback"></div>
                            </div>

                            <div class="form-group col-4">
                                <legend class="col-form-label font-weight-bold">파일업로드 여부</legend>
                                <div class="form-check-inline">
                                    <input class="form-check-input" type="radio" name="enableFileUpload" id="enableFileUpload0"
                                           :value="true" v-model.boolean="board.enableFileUpload">
                                    <label class="form-check-label" for="enableFileUpload0">사용</label>
                                </div>
                                <div class="form-check-inline">
                                    <input class="form-check-input" type="radio" name="enableFileUpload" id="enableFileUpload1"
                                           :value="false" v-model.boolean="board.enableFileUpload">
                                    <label class="form-check-label" for="enableFileUpload1">사용안함</label>
                                </div>
                                <div id="enableFileUploadError" class="invalid-feedback"></div>
                            </div>

                            <div class="form-group col-4">
                                <label for="uploadableNumberOfFiles">파일 업로드 갯수</label>
                                <input type="email" class="form-control" id="uploadableNumberOfFiles" name="uploadableNumberOfFiles"
                                       v-model.number="board.uploadableNumberOfFiles" required>
                                <div id="uploadableNumberOfFilesError" class="invalid-feedback"></div>
                            </div>

                            <div class="form-group col-4">
                                <legend class="col-form-label font-weight-bold">활성화 여부</legend>
                                <div class="form-check-inline">
                                    <input class="form-check-input" type="radio" name="enable" id="enable0"
                                           :value="true" v-model.boolean="board.enable">
                                    <label class="form-check-label" for="enable0">사용</label>
                                </div>
                                <div class="form-check-inline">
                                    <input class="form-check-input" type="radio" name="enable" id="enable1"
                                           :value="false" v-model.boolean="board.enable">
                                    <label class="form-check-label" for="enable1">사용안함</label>
                                </div>
                                <div id="enableError" class="invalid-feedback"></div>
                            </div>
                        </div>

                    </div>
                </div>
                <div class="modal-footer justify-content-between">
                    <div class="col-auto ml-auto">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
<%--                        <auth:authorize method="C,U">--%>
                        <button type="button" class="btn btn-primary" @click="save">{{isUpdate ? '저장' : '등록'}}
                        </button>
<%--                        </auth:authorize>--%>
                    </div>
                </div>
            </div>
        </div>
    </div>
</script>

<script>
    var boardModalFormComponent = {
        template: '#board-modal-form-component',
        mixins: [mixinForm],
        props: ["type"],
        data: function () {
            return {
                id: null,
                board: {
                    id: null,
                    type: 'QNA',
                    name: '',
                    enableSecret: false,
                    enableReply: false,
                    enableComment: false,
                    enableWriteAnonymousUser: false,
                    enableEditor: false,
                    enableFileUpload: false,
                    uploadableNumberOfFiles: 0,
                    enable: true
                }
            }
        },
        methods: {
            save: function () {
                var self = this;
                var url = contextPath + "/admin/boards";
                if (this.isUpdate) {
                    url += "/" + this.board.id;
                }

                jQuery.ajax(url, {
                    method: self.isUpdate ? 'PUT' : 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(self.board)
                }).done(function (data) {
                    console.log('done');
                    var callback = function (isConfirm) {
                        location.reload();
                    }
                    $('#boardModal').modal('hide');
                    self.isUpdate ? alertUpdated() : alertSuccessAfterCallback(callback, "등록되었습니다!");
                }).fail(function (data) {
                    console.log('fail');
                    displayErrors(data);
                });
            },
            clearModalForm: function () {
                this.id = null;
                this.board = {
                    id: null,
                    type: 'QNA',
                    name: '',
                    enableSecret: false,
                    enableReply: false,
                    enableComment: false,
                    enableWriteAnonymousUser: false,
                    enableEditor: false,
                    enableFileUpload: false,
                    uploadableNumberOfFiles: 0,
                    enable: true
                };
                clearInvalid();
            },
            openDetail: function (data) {
                console.log(data)
                this.board = data;
                this.board.type = data.type.code;
                this.id = data.id;
                $('#boardModal').modal('show');
            }
        }
    }

</script>









