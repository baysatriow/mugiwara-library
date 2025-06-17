package DAO;

import Models.Publisher;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class PublisherDAO extends Models<Publisher> {

    public PublisherDAO() {
        table = "publisher";
        primaryKey = "publisher_id";
    }

    @Override
    Publisher toModel(ResultSet rs) {
        try {
            Publisher publisher = new Publisher();
            publisher.setPublisher_id(rs.getInt("publisher_id"));
            publisher.setName(rs.getString("name"));
            publisher.setDescription(rs.getString("description"));
            return publisher;
        } catch (SQLException e) {
            setMessage("Error creating Publisher model: " + e.getMessage());
            return null;
        }
    }

    public ArrayList<Publisher> getAllPublishers() {
        try {
            addQuery("ORDER BY name");
            return get();
        } catch (Exception e) {
            setMessage("Error getting all publishers: " + e.getMessage());
            return new ArrayList<>();
        }
    }
}
