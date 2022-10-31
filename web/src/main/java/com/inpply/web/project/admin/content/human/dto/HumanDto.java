package com.inpply.web.project.admin.content.human.dto;

import com.inpply.common.domain.file.model.File;
import com.inpply.web.global.dto.BaseDto;
import com.inpply.web.infra.upload.ExcelDtoCreator;
import com.inpply.web.module.banner.type.BannerType;
import lombok.Data;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;

import javax.persistence.Column;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.OneToMany;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import java.util.List;

@Data
public class HumanDto extends BaseDto implements ExcelDtoCreator {

    private Boolean isPublic;
    @NotBlank(message = "이름(국문)을 입력하세요.")
    private String krName;
    private String cnName;
    private String enName;
    @NotBlank(message = "직위를 입력하세요.")
    private String position;
    @NotBlank(message = "생년을 입력하세요.")
    private String birthYear;
    private String address;
    private String email;
    @NotBlank(message = "학력을 입력하세요.")
    private String education;
    @NotBlank(message = "경력사항을 입력하세요.")
    private String career;
    private String writing;
    private String paper;
    private String awards;
    private String etc1;
    private String etc2;
    private Integer readCount;
    List<File> files;
    
    protected String getCellValue(Cell cell)
    {
        return cell != null ? cell.getStringCellValue() : "";
    }
    @Override
    public ExcelDtoCreator rowToDto(Row row) {
        int index = 0;
        this.krName = getCellValue(row.getCell(index++));
        this.cnName = getCellValue(row.getCell(index++));
        this.enName = getCellValue(row.getCell(index++));
        this.position = getCellValue(row.getCell(index++));
        this.birthYear = getCellValue(row.getCell(index++));
        this.address = getCellValue(row.getCell(index++));
        this.email = getCellValue(row.getCell(index++));
        this.education = getCellValue(row.getCell(index++));
        this.career = getCellValue(row.getCell(index++));
        this.writing = getCellValue(row.getCell(index++));
        this.paper = getCellValue(row.getCell(index++));
        this.awards = getCellValue(row.getCell(index++));
        this.etc1 = getCellValue(row.getCell(index++));
        this.etc2 = getCellValue(row.getCell(index++));
        this.readCount = 0;
        this.isPublic = true;

        return this;
    }

    @Data
    public static class ApiItem extends BaseDto{
        private String krName;
        private String cnName;
        private String enName;
        private String position;
        private String birthYear;
        private String address;
        private String email;
        private String education;
        private String career;
        private String writing;
        private String paper;
        private String awards;
        private String etc1;
        private String etc2;
        private File file;
    }

    @Data
    public static class ListItem extends BaseDto {
        private Boolean isPublic;
        private String krName;
        private String enName;
        private String cnName;
        private String education;
        private String career;
        private String name;
        private String position;
        private String birthYear;
        private Integer readCount;
        private Long fileId;
    }

    @Data
    public static class ApiListItem extends BaseDto {
        private String krName;
        private String enName;
        private String cnName;
        private String education;
        private String career;
        private String position;
        private String birthYear;
        private File file;
    }
}
