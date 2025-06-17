package DAO;

import Models.BannerSlide;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;

public class BannerSlideDAO extends Models<BannerSlide> {
    
    public BannerSlideDAO() {
        table = "banner_slide";
        primaryKey = "banner_id";
    }
    
    @Override
    BannerSlide toModel(ResultSet rs) {
        try {
            BannerSlide banner = new BannerSlide();
            
            // Handle primary key
            banner.setBannerID(rs.getInt("banner_id"));
            
            // Handle string fields with null checks
            banner.setTitle(rs.getString("title"));
            banner.setDescription(rs.getString("description"));
            banner.setImagePath(rs.getString("image_path"));
            banner.setLinkUrl(rs.getString("link_url"));
            
            // Handle boolean field
            banner.setIsActive(rs.getBoolean("is_active"));
            
            // Handle integer field with default value
            try {
                banner.setOrder(rs.getInt("order"));
            } catch (SQLException e) {
                banner.setOrder(rs.getInt("`order`")); // Try with backticks
            }
            
            // Handle optional datetime fields with null checks
            try {
                if (rs.getTimestamp("start_date") != null) {
                    banner.setStartDate(rs.getTimestamp("start_date").toLocalDateTime());
                }
            } catch (SQLException e) {
                // Field might not exist, ignore
                System.out.println("start_date field not found or null");
            }
            
            try {
                if (rs.getTimestamp("end_date") != null) {
                    banner.setEndDate(rs.getTimestamp("end_date").toLocalDateTime());
                }
            } catch (SQLException e) {
                // Field might not exist, ignore
                System.out.println("end_date field not found or null");
            }
            
            try {
                if (rs.getTimestamp("created_at") != null) {
                    banner.setCreateAt(rs.getTimestamp("created_at"));
                }
            } catch (SQLException e) {
                // Field might not exist, ignore
                System.out.println("created_at field not found or null");
            }
            
            try {
                if (rs.getTimestamp("updated_at") != null) {
                    banner.setUploadAt(rs.getTimestamp("updated_at"));
                }
            } catch (SQLException e) {
                // Field might not exist, ignore
                System.out.println("updated_at field not found or null");
            }
            
            // Handle user ID fields with default values
            try {
                banner.setCreatedBy(rs.getInt("created_by"));
            } catch (SQLException e) {
                banner.setCreatedBy(0);
            }
            
            try {
                banner.setUpdatedBy(rs.getInt("updated_by"));
            } catch (SQLException e) {
                banner.setUpdatedBy(0);
            }
            
            return banner;
        } catch (SQLException e) {
            setMessage("Error in toModel: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }
    
    // Override find method with better error handling
    @Override
    public BannerSlide find(String pkValue) {
        try {
            connect();
            String query = "SELECT * FROM " + table + " WHERE " + primaryKey + " = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, pkValue);
            
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                BannerSlide banner = toModel(rs);
                setMessage("Banner found successfully");
                return banner;
            } else {
                setMessage("Banner not found with ID: " + pkValue);
                return null;
            }
        } catch (SQLException e) {
            setMessage("Error finding banner: " + e.getMessage());
            e.printStackTrace();
            return null;
        } finally {
            disconnect();
        }
    }
    
    // Get all banners with pagination
    public ArrayList<BannerSlide> getBanners(int page, int limit) {
        int offset = (page - 1) * limit;
        try {
            addQuery("ORDER BY `order` ASC LIMIT " + limit + " OFFSET " + offset);
        } catch (Exception e) {
            addQuery("ORDER BY banner_id DESC LIMIT " + limit + " OFFSET " + offset);
        }
        return get();
    }
    
    // Get active banners only
    public ArrayList<BannerSlide> getActiveBanners() {
        where("is_active = 1");
        try {
            addQuery("ORDER BY `order` ASC");
        } catch (Exception e) {
            addQuery("ORDER BY banner_id ASC");
        }
        return get();
    }
    
    // Get banners by status
    public ArrayList<BannerSlide> getBannersByStatus(boolean isActive) {
        where("is_active = " + (isActive ? 1 : 0));
        try {
            addQuery("ORDER BY `order` ASC");
        } catch (Exception e) {
            addQuery("ORDER BY banner_id ASC");
        }
        return get();
    }
    
    // Get banners by date range
    public ArrayList<BannerSlide> getBannersByDateRange(LocalDateTime startDate, LocalDateTime endDate) {
        where("(start_date IS NULL OR start_date <= '" + startDate + "') AND " +
              "(end_date IS NULL OR end_date >= '" + endDate + "')");
        try {
            addQuery("ORDER BY `order` ASC");
        } catch (Exception e) {
            addQuery("ORDER BY banner_id ASC");
        }
        return get();
    }
    
    // Count total banners
    public int countBanners() {
        try {
            connect();
            String query = "SELECT COUNT(*) as total FROM " + table;
            ResultSet rs = stmt.executeQuery(query);
            if (rs.next()) {
                return rs.getInt("total");
            }
            return 0;
        } catch (SQLException e) {
            setMessage("Error counting banners: " + e.getMessage());
            return 0;
        } finally {
            disconnect();
        }
    }
    
    // Count banners by status
    public int countBannersByStatus(boolean isActive) {
        try {
            connect();
            String query = "SELECT COUNT(*) as total FROM " + table + " WHERE is_active = " + (isActive ? 1 : 0);
            ResultSet rs = stmt.executeQuery(query);
            if (rs.next()) {
                return rs.getInt("total");
            }
            return 0;
        } catch (SQLException e) {
            setMessage("Error counting banners by status: " + e.getMessage());
            return 0;
        } finally {
            disconnect();
        }
    }
    
    // Insert new banner with prepared statement
    public boolean insertBannerSlide(BannerSlide banner) {
        try {
            connect();
            String query = "INSERT INTO " + table + " (title, description, image_path, link_url, is_active, `order`, " +
                          "start_date, end_date, created_at, created_by) VALUES (?, ?, ?, ?, ?, ?, ?, ?, NOW(), ?)";
            
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, banner.getTitle());
            pstmt.setString(2, banner.getDescription());
            pstmt.setString(3, banner.getImagePath());
            pstmt.setString(4, banner.getLinkUrl());
            pstmt.setBoolean(5, banner.isIsActive());
            pstmt.setInt(6, banner.getOrder());
            
            if (banner.getStartDate() != null) {
                pstmt.setObject(7, banner.getStartDate());
            } else {
                pstmt.setNull(7, java.sql.Types.TIMESTAMP);
            }
            
            if (banner.getEndDate() != null) {
                pstmt.setObject(8, banner.getEndDate());
            } else {
                pstmt.setNull(8, java.sql.Types.TIMESTAMP);
            }
            
            pstmt.setInt(9, banner.getCreatedBy());
            
            int result = pstmt.executeUpdate();
            setMessage("Banner inserted: " + result + " rows affected");
            return result > 0;
        } catch (SQLException e) {
            setMessage("Error inserting banner: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            disconnect();
        }
    }
    
    // Update banner with prepared statement
    public boolean updateBannerSlide(BannerSlide banner) {
        try {
            connect();
            String query = "UPDATE " + table + " SET " +
                          "title = ?, description = ?, image_path = ?, link_url = ?, is_active = ?, `order` = ?, " +
                          "start_date = ?, end_date = ?, updated_at = NOW(), updated_by = ? " +
                          "WHERE " + primaryKey + " = ?";
            
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, banner.getTitle());
            pstmt.setString(2, banner.getDescription());
            pstmt.setString(3, banner.getImagePath());
            pstmt.setString(4, banner.getLinkUrl());
            pstmt.setBoolean(5, banner.isIsActive());
            pstmt.setInt(6, banner.getOrder());
            
            if (banner.getStartDate() != null) {
                pstmt.setObject(7, banner.getStartDate());
            } else {
                pstmt.setNull(7, java.sql.Types.TIMESTAMP);
            }
            
            if (banner.getEndDate() != null) {
                pstmt.setObject(8, banner.getEndDate());
            } else {
                pstmt.setNull(8, java.sql.Types.TIMESTAMP);
            }
            
            pstmt.setInt(9, banner.getUpdatedBy());
            pstmt.setInt(10, banner.getBannerID());
            
            int result = pstmt.executeUpdate();
            setMessage("Banner updated: " + result + " rows affected");
            return result > 0;
        } catch (SQLException e) {
            setMessage("Error updating banner: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            disconnect();
        }
    }
    
    // Update banner order
    public boolean updateOrder(int bannerId, int newOrder) {
        try {
            connect();
            String query = "UPDATE " + table + " SET `order` = ?, updated_at = NOW() WHERE " + primaryKey + " = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1, newOrder);
            pstmt.setInt(2, bannerId);
            
            int result = pstmt.executeUpdate();
            setMessage("Order updated: " + result + " rows affected");
            return result > 0;
        } catch (SQLException e) {
            setMessage("Error updating order: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            disconnect();
        }
    }
    
    // Toggle active status
    public boolean toggleActiveStatus(int bannerId) {
        try {
            connect();
            String query = "UPDATE " + table + " SET is_active = NOT is_active, updated_at = NOW() WHERE " + primaryKey + " = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1, bannerId);
            
            int result = pstmt.executeUpdate();
            setMessage("Status updated: " + result + " rows affected");
            return result > 0;
        } catch (SQLException e) {
            setMessage("Error updating status: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            disconnect();
        }
    }
    
    // Get maximum order number
    public int getMaxOrder() {
        try {
            connect();
            String query = "SELECT COALESCE(MAX(`order`), 0) as max_order FROM " + table;
            ResultSet rs = stmt.executeQuery(query);
            if (rs.next()) {
                return rs.getInt("max_order");
            }
            return 0;
        } catch (SQLException e) {
            setMessage("Error getting max order: " + e.getMessage());
            return 0;
        } finally {
            disconnect();
        }
    }
    
    // Delete banner (override from Models)
    public boolean deleteBanner(int bannerId) {
        try {
            connect();
            String query = "DELETE FROM " + table + " WHERE " + primaryKey + " = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1, bannerId);
            
            int result = pstmt.executeUpdate();
            setMessage("Banner deleted: " + result + " rows affected");
            return result > 0;
        } catch (SQLException e) {
            setMessage("Error deleting banner: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            disconnect();
        }
    }
    
    // Search banners
    public ArrayList<BannerSlide> searchBanners(String keyword) {
        where("(title LIKE '%" + keyword + "%' OR description LIKE '%" + keyword + "%')");
        try {
            addQuery("ORDER BY `order` ASC");
        } catch (Exception e) {
            addQuery("ORDER BY banner_id ASC");
        }
        return get();
    }
    
    // Debug method to test connection and table structure
    public void debugTableStructure() {
        try {
            connect();
            String query = "DESCRIBE " + table;
            ResultSet rs = stmt.executeQuery(query);
            System.out.println("=== Table Structure for " + table + " ===");
            while (rs.next()) {
                System.out.println("Field: " + rs.getString("Field") + 
                                 ", Type: " + rs.getString("Type") + 
                                 ", Null: " + rs.getString("Null") + 
                                 ", Key: " + rs.getString("Key"));
            }
            System.out.println("=== End Table Structure ===");
        } catch (SQLException e) {
            System.err.println("Error getting table structure: " + e.getMessage());
            e.printStackTrace();
        } finally {
            disconnect();
        }
    }
}