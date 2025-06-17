package Models;

import java.sql.Timestamp;
import java.time.LocalDateTime;

public class BannerSlide {
    private int bannerID;
    private String title;
    private String description;
    private String imagePath;
    private String linkUrl;
    private boolean isActive;
    private int order;
    private LocalDateTime startDate;
    private LocalDateTime endDate;
    private Timestamp createAt;
    private Timestamp uploadAt;
    private int createdBy;
    private int updatedBy;

    // Default constructor
    public BannerSlide() {
        this.isActive = true;
        this.order = 1;
    }

    // Constructor with parameters
    public BannerSlide(String title, String description, String imagePath, String linkUrl) {
        this();
        this.title = title;
        this.description = description;
        this.imagePath = imagePath;
        this.linkUrl = linkUrl;
    }

    // Business methods
    public void updateBanner(String title, String description, String linkUrl) {
        this.title = title;
        this.description = description;
        this.linkUrl = linkUrl;
    }

    public void setDateRange(LocalDateTime startDate, LocalDateTime endDate) {
        this.startDate = startDate;
        this.endDate = endDate;
    }

    public boolean isCurrentlyActive() {
        if (!isActive) return false;
        
        LocalDateTime now = LocalDateTime.now();
        
        if (startDate != null && now.isBefore(startDate)) {
            return false;
        }
        
        if (endDate != null && now.isAfter(endDate)) {
            return false;
        }
        
        return true;
    }

    // Getters and Setters
    public int getBannerID() {
        return bannerID;
    }

    public void setBannerID(int bannerID) {
        this.bannerID = bannerID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    public String getLinkUrl() {
        return linkUrl;
    }

    public void setLinkUrl(String linkUrl) {
        this.linkUrl = linkUrl;
    }

    public boolean isIsActive() {
        return isActive;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }

    public int getOrder() {
        return order;
    }

    public void setOrder(int order) {
        this.order = order;
    }

    public LocalDateTime getStartDate() {
        return startDate;
    }

    public void setStartDate(LocalDateTime startDate) {
        this.startDate = startDate;
    }

    public LocalDateTime getEndDate() {
        return endDate;
    }

    public void setEndDate(LocalDateTime endDate) {
        this.endDate = endDate;
    }

    public Timestamp getCreateAt() {
        return createAt;
    }

    public void setCreateAt(Timestamp createAt) {
        this.createAt = createAt;
    }

    public Timestamp getUploadAt() {
        return uploadAt;
    }

    public void setUploadAt(Timestamp uploadAt) {
        this.uploadAt = uploadAt;
    }

    public int getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(int createdBy) {
        this.createdBy = createdBy;
    }

    public int getUpdatedBy() {
        return updatedBy;
    }

    public void setUpdatedBy(int updatedBy) {
        this.updatedBy = updatedBy;
    }

    @Override
    public String toString() {
        return "BannerSlide{" +
                "bannerID=" + bannerID +
                ", title='" + title + '\'' +
                ", description='" + description + '\'' +
                ", imagePath='" + imagePath + '\'' +
                ", linkUrl='" + linkUrl + '\'' +
                ", isActive=" + isActive +
                ", order=" + order +
                ", startDate=" + startDate +
                ", endDate=" + endDate +
                ", createAt=" + createAt +
                ", uploadAt=" + uploadAt +
                ", createdBy=" + createdBy +
                ", updatedBy=" + updatedBy +
                '}';
    }
}