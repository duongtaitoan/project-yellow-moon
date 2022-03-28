/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dtos;

import java.io.Serializable;

public class LogDTO implements Serializable {

    private int logID;
    private int cakeID;
    private String userID;
    private String description;
    private String date;

    public LogDTO() {
    }

    public LogDTO(int logID, int cakeID, String userID, String description, String date) {
        this.logID = logID;
        this.cakeID = cakeID;
        this.userID = userID;
        this.description = description;
        this.date = date;
    }

    public int getLogID() {
        return logID;
    }

    public void setLogID(int logID) {
        this.logID = logID;
    }

    public int getCakeID() {
        return cakeID;
    }

    public void setCakeID(int cakeID) {
        this.cakeID = cakeID;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

}
