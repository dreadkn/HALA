package com.inpply.web.global.model;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.util.StringUtils;

@Slf4j
public class DataTable {

    @Data
    public static class Sent {

        private Integer draw;
        private Integer start;
        private Integer length;
        private Search search = new Search();
        private List<Order> order = new ArrayList<>();
        private List<Column> columns = new ArrayList<>();

        public Pageable getPageable() {
            Sort sort = Sort.by(order.stream().map(o -> o.toOrder(columns)).collect(Collectors.toList()));
            log.debug("sort: {}", sort);
            return PageRequest.of(start / length, length, sort);
        }

        @Data
        public static class Search {

            private String value;
            private Boolean regex;
        }

        @Data
        public static class Order {

            private Integer column;
            private String dir;

            public Sort.Order toOrder(List<Column> columns) {
                return new Sort.Order(Direction.fromString(dir), columns.get(column).getField());
            }
        }

        @Data
        public static class Column {

            private String data;
            private String name;
            private Boolean searchable;
            private Boolean orderable;
            private Search search = new Search();

            public String getField() {
                return StringUtils.hasText(name) ? name : data;
            }
        }
    }

    @Data
    public static class Returned<T> {

        private Integer draw;
        private long recordsTotal;
        private long recordsFiltered;
        private List<T> data = Collections.emptyList();
        private String error;
        Page<T> page;


        public Returned(Sent sent, Page<T> page) {
            this.draw = sent.draw;
            this.recordsTotal = page.getTotalElements();
            this.recordsFiltered = page.getTotalElements();
            this.data = page.getContent();
            this.error = "";
            this.page = page;
        }
    }

}
