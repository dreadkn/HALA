<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<%@ include file="/WEB-INF/view/common/dropzone.jsp" %>

<div id="vue-app" class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h4 class="m-0 text-dark">[{{board.typeName}}] {{board.name}}</h4>
                </div>
            </div>
        </div>
    </div>
    <!-- /.content-header -->

    <!-- Main content -->
    <div class="content">
        <div class="container-fluid">
            <div class="card card-light">
                <div class="card-header">
                    <div class="d-flex justify-content-between">
                        <h3 class="card-title">게시글 {{txtTitle}}</h3>
                        <div v-if="isUpdate">
                            <span><i class="far fa-eye"></i> : {{data.readCount}}</span>
                        </div>
                    </div>
                </div>

                <div class="card-body">

                    <form>
                        <div class="form-row" v-if="data.status != null">
                            <span class="badge badge-md badge-white mr-1 mb-4">{{data.status.value}}</span>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-10">
                                <label for="title">제목 <small class="text-danger">*</small></label>
                                <input type="text" class="form-control" id="title" name="title" v-model="data.title" maxlength="200">
                                <div id="titleError" class="invalid-feedback"></div>
                            </div>
                            <div class="form-group col-12">
                                <label for="content">{{txtContent}} <small class="text-danger">*</small></label>

                                <textarea rows="15" class="form-control" id="content" name="content" v-model="data.content" aria-label="본문"></textarea>
                                <div id="contentError" class="invalid-feedback"></div>
                            </div>
                            <div class="form-group col-12" v-if="isQna">
                                <label for="content">Answer</label>
                                <textarea rows="10" class="form-control" id="answer" name="answer" v-model="data.answer" aria-label="답변"></textarea>
                                <div id="answerError" class="invalid-feedback"></div>
                            </div>
                        </div>

                        <%--파일 업로드--%>
                        <div class="form-row" v-if="board.enableFileUpload">
                            <div class="form-group col-md-12">
                                <legend class="col-form-label pt-0 font-weight-bold">파일</legend>
                                <div class="input-group mb-3">
                                    <dropzone-component ref="dropzone" :files="data.files" :delete="false" :max-files="board.uploadableNumberOfFiles"></dropzone-component>
                                </div>
                            </div>
                        </div>

                        <template v-if="board.enableWriteAnonymousUser">
                            <div class="form-row">
                                <div class="form-group col-md-4">
                                    <label for="writer">작성자명<small class="text-danger">*</small></label>
                                    <input type="text" class="form-control" id="writer" name="writer" v-model="data.writer">
                                    <div id="writerError" class="invalid-feedback"></div>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group col-md-4">
                                    <label for="password">비밀번호 <small class="text-danger">*</small></label>
                                    <input type="password" class="form-control" id="password" name="password" v-model="data.password">
                                    <div id="passwordError" class="invalid-feedback"></div>
                                </div>
                            </div>
                        </template>

                        <div class="form-row">
                            <div class="form-group col-md-3 col-6">
                                <label>게시글 삭제 여부</label>
                                <div>
                                    <div class="custom-control custom-radio custom-control-inline">
                                        <input class="form-check-input" type="radio" name="deleted" id="deleted1"
                                               :value="false" v-model.boolean="data.deleted" checked>
                                        <label class="form-check-label" for="deleted1">정상</label>
                                    </div>
                                    <div class="custom-control custom-radio custom-control-inline">
                                        <input class="form-check-input" type="radio" name="deleted" id="deleted2"
                                               :value="true" v-model.boolean="data.deleted">
                                        <label class="form-check-label" for="deleted2">삭제</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                    <%--                    <textarea id="sample"></textarea>--%>

                </div>
                <div class="card-footer">
                    <div class="row justify-content-end">
                        <div class="col-auto">
                            <button type="button" @click="back" class="btn btn-secondary">목록</button>
                        </div>
                        <div class="col-auto">
                            <button type="button" class="btn btn-primary" @click="save">{{txtButton}}</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>

    var boardId = "${boardId}";
    var id = "${articleId}";

    // Root
    var vm = new Vue({
        el: '#vue-app',
        mixins: [mixinForm],
        mounted: function () {
            this.fetchByBoard();

            if (this.isNew)
                if (this.board.enableEditor)
                    this.initEditor();

            if (this.isUpdate) {
                this.fetch();
            }
        },
        watch : {
            board : function(){
                if (this.board.enableEditor)
                {
                    this.initEditor();
                }
            }
        },
        computed: {
            txtTitle: function () {
                return this.isNew ? '등록' : '수정';
            },
            txtButton: function () {
                return this.isUpdate ? '저장' : '등록';
            },
            txtContent: function () {
                return this.board.type == 'QNA' ? 'Question' : this.board.type == 'FAQ' ? 'Answer' : '내용';
            },
            isQna: function () {
                return this.board.type == 'QNA';
            }
        },
        data: {
            boardId: boardId,
            id: id,
            member: {},
            board: {},
            data: {
                id: id,
                boardId: boardId,
                parentArticleId: null,
                status: null,
                title: '',
                content: '',
                writer: null,
                answer: null,
                password: null,
                notice: false,
                secret: false,
                deleted: false
            },
            editor: null,
        },
        methods: {
            fetch: function () {
                var self = this;
                jQuery.ajax(contextPath + "/admin/boards/" + this.boardId + "/" + this.id, {
                    method: 'GET',
                    contentType: 'application/json'
                }).done(function (data) {
                    self.data = data;
                    if (self.editor != null) {
                        self.editor.setContents(data.content);
                    }
                })
                    .fail(function (data) {
                        errorToastr("조회중 오류가 발생하였습니다.");
                    })
            },
            fetchByBoard: function () {
                var self = this;
                jQuery.ajax(contextPath + "/admin/boards/" + this.boardId + "/board", {
                    method: 'GET',
                    contentType: 'application/json'
                }).done(function (data) {
                    self.board = data;
                    if (self.board.enableEditor) {
                        self.initEditor();
                    }
                })
                    .fail(function (data) {
                        errorToastr("조회중 오류가 발생하였습니다.");
                    });
            },
            save: function () {
                var self = this;
                if (this.$refs.dropzone != null) {
                    this.data.files = this.$refs.dropzone.getUploadFileIds();
                }

                if (this.board.enableEditor && self.editor.getContents() != null) {
                    this.data.content = self.editor.getContents();
                }

                var url = contextPath + "/admin/boards/" + this.boardId;
                if (this.isUpdate) {
                    url += "/" + this.id;
                }


                jQuery.ajax(url, {
                    method: self.isNew ? 'POST' : 'PUT',
                    contentType: 'application/json',
                    data: JSON.stringify(self.data)
                }).done(function (data) {
                    self.isNew ? alertRegistered() : alertUpdated();
                    setTimeout(function () {
                        self.back();
                    }, 1500);
                }).fail(function (data) {
                    displayErrors(data);
                });
            },
            initEditor: function () {
                var self = this;
                self.editor = SUNEDITOR.create((document.getElementById('content') || 'content'), $.extend(true, sunEditorConfig, {
                        imageUploadHeader: {
                            'X-Requested-With': 'XMLHttpRequest',
                            'x-csrf-token': document.querySelectorAll('meta[name=X-CSRF-TOKEN]')[0].getAttributeNode('content').value
                        },
                    })
                );
            },
            back: function () {
                back('/admin/boards/' + this.boardId);
            }
        }
    });

</script>

<script>

    // SUNEDITOR.create((document.getElementById('sample') || 'sample'), {
    //    lang: SUNEDITOR_LANG['ko']
    // });
</script>

