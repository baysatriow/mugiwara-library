package Models;

import java.sql.Timestamp;

/**
 *
 * @author bayus
 */
public class ReportType extends Report{
    private String name;
    private String description;

    public ReportType(String name, String description, String ReportType, String title, String generatedBy, Timestamp generatedAt, String reportData) {
        super(ReportType, title, generatedBy, generatedAt, reportData);
        this.name = name;
        this.description = description;
    }
   
}
