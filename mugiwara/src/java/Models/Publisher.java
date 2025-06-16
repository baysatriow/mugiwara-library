package Models;

/**
 *
 * @author ASUS
 */
    public class Publisher {
    private int publisher_id;
    private String name;
    private String description;
    private Book[] publication;

    public Publisher(String name, String description) {
        this.name = name;
        this.description = description;
    }

    public Publisher(int publisher_id, String name, String description) {
        this.publisher_id = publisher_id;
        this.name = name;
        this.description = description;
    }

    public Publisher() {}

    public String getPublisher() {
        return name;
    }

    public void setPublication(Book[] publication) {
        this.publication = publication;
    }

    public void publisherInfo() {

    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    
    public int getPublisher_id() {
        return publisher_id;
    }

    public void setPublisher_id(int publisher_id) {
        this.publisher_id = publisher_id;
    }
}
