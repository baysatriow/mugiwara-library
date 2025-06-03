package Models;

import java.time.LocalDateTime;
import java.sql.Timestamp;

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

    public void updateBanner(String title, String description, String linkUrl) {
        this.title = title;
        this.description = description;
        this.linkUrl = linkUrl;
    }

    public void setDataRange(LocalDateTime startDate, LocalDateTime endDate) {
        this.startDate = startDate;
        this.endDate = endDate;
    }

    public int getBannerID() {
        return bannerID;
    }

    public String getTitle() {
        return title;
    }

    public String getDescription() {
        return description;
    }

    public String getImagePath() {
        return imagePath;
    }

    public String getLinkUrl() {
        return linkUrl;
    }

    public boolean isIsActive() {
        return isActive;
    }

    public int getOrder() {
        return order;
    }

    public LocalDateTime getStartDate() {
        return startDate;
    }

    public LocalDateTime getEndDate() {
        return endDate;
    }

    public Timestamp getCreateAt() {
        return createAt;
    }

    public Timestamp getUploadAt() {
        return uploadAt;
    }

    public int getCreatedBy() {
        return createdBy;
    }

    public int getUpdatedBy() {
        return updatedBy;
    }

    public void setBannerID(int bannerID) {
        this.bannerID = bannerID;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    public void setLinkUrl(String linkUrl) {
        this.linkUrl = linkUrl;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }

    public void setOrder(int order) {
        this.order = order;
    }

    public void setStartDate(LocalDateTime startDate) {
        this.startDate = startDate;
    }

    public void setEndDate(LocalDateTime endDate) {
        this.endDate = endDate;
    }

    public void setCreateAt(Timestamp createAt) {
        this.createAt = createAt;
    }

    public void setUploadAt(Timestamp uploadAt) {
        this.uploadAt = uploadAt;
    }

    public void setCreatedBy(int createdBy) {
        this.createdBy = createdBy;
    }

    public void setUpdatedBy(int updatedBy) {
        this.updatedBy = updatedBy;
    }
}
