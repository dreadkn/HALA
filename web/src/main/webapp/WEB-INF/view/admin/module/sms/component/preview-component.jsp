<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<script type="text/x-template" id="preview-component">
        <div class="modal fade" id="previewModal" data-backdrop="static" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modalFormLabel">문자발송 미리보기</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="container-fluid ">
                            <div class="row ">
                                <div class="col">
                                    <textarea placeholder="메시지를 입력해주세요." rows="5" name="message" id="previewMessage" class="form-control"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer justify-content-between">
                        <div class="col-auto ml-auto">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                            <button type="button" class="btn btn-primary" @click="send">전송</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
</script>

<script>
    var previewComponent = {
        template: '#preview-component',
        mounted: function () {
        },
        data: function(){
            return {

            }
        },
        methods: {
            open: function (message) {
                $('#previewMessage').val(message);
                $('#previewModal').modal('show');
            },
            send: function(){
                vm.send();
                $('#previewModal').modal('hide');
            }
        }
    }
</script>
