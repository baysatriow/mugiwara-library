package DAO;

import Models.Author;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class AuthorDAO extends Models<Author> {

    public AuthorDAO() {
        table = "author";
        primaryKey = "author_id";
    }

    @Override
    Author toModel(ResultSet rs) {
        try {
            Author author = new Author();
            author.setAuthor_id(rs.getInt("author_id"));
            author.setName(rs.getString("name"));
            author.setDescription(rs.getString("description"));
            return author;
        } catch (SQLException e) {
            setMessage("Error creating Author model: " + e.getMessage());
            return null;
        }
    }

    public ArrayList<Author> getAllAuthors() {
        try {
            addQuery("ORDER BY name");
            return get();
        } catch (Exception e) {
            setMessage("Error getting all authors: " + e.getMessage());
            return new ArrayList<>();
        }
    }
}
