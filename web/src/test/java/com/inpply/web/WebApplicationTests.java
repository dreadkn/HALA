package com.inpply.web;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;

@SpringBootTest(classes = WebApplication.class)
@ActiveProfiles({"default", "test"})
class WebApplicationTests {

    @Test
    void contextLoads() {
    }

}
