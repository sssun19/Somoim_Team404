package test.com.moim.mongo.board;

import org.bson.Document;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.mongodb.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Configuration
public class MongoBoardConfig {

    @Bean
    public MongoDatabase mongoDatabase() {
        MongoClient client = new MongoClient("localhost",27017);
        MongoDatabase db = client.getDatabase("onandoff");//db name
        log.info("Create Bean MongoDatabase...onandoff");
        return db;
    }

    @Bean
    public MongoCollection<Document> gallery() {
        MongoCollection<Document> collection = mongoDatabase().getCollection("gallery");
        log.info("Create Bean gallery...");
        return collection;
    }

}
