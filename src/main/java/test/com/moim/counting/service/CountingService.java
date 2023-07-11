package test.com.moim.counting.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import test.com.moim.counting.model.CountingDAO;

@Service
@Slf4j
public class CountingService {
    @Autowired
    CountingDAO dao;


}
