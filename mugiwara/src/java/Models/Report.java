package Models;

import java.sql.Timestamp;

/**
 *
 * @author bayus
 */
public class Report {
    private String ReportType;
    private String title;
    private String generatedBy;
    private Timestamp generatedAt;
    private String reportData;

    public Report(String ReportType, String title, String generatedBy, Timestamp generatedAt, String reportData) {
        this.ReportType = ReportType;
        this.title = title;
        this.generatedBy = generatedBy;
        this.generatedAt = generatedAt;
        this.reportData = reportData;
    }

    public String getReportType() {
        return ReportType;
    }

    public void setReportType(String ReportType) {
        this.ReportType = ReportType;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getGeneratedBy() {
        return generatedBy;
    }

    public void setGeneratedBy(String generatedBy) {
        this.generatedBy = generatedBy;
    }

    public Timestamp getGeneratedAt() {
        return generatedAt;
    }

    public void setGeneratedAt(Timestamp generatedAt) {
        this.generatedAt = generatedAt;
    }

    public String getReportData() {
        return reportData;
    }

    public void setReportData(String reportData) {
        this.reportData = reportData;
    }
    
    
}
