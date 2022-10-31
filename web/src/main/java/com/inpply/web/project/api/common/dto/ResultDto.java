package com.inpply.web.project.api.common.dto;

import lombok.Data;

@Data
public class ResultDto {

    @Data
    public static class Result {
        private Long id = null;
        private Boolean result = false;
        private String message  = null;
        private String code  = null;


        private String reserve1  = null;
        private String reserve2  = null;
        private String reserve3 = null;
        public void setSuccess() {
            this.result = true;
        }
        public void setSuccess(Long id) {
            this.result = true;
            this.id = id;
        }

        public void setFail(String message) {
            this.result = false;
            this.message = message;
        }

        public void setFailCode(String code) {
            this.result = false;
            this.code = code;
        }
    }
}
