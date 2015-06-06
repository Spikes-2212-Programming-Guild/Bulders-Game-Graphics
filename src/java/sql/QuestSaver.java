/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sql;

import java.sql.SQLException;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import members.Grade;
import members.Member;
import members.Skill;
import quests.Quest;

/**
 *
 * @author thinkredstone
 */
public class QuestSaver {

    // JDBC driver name and database URL
    static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    static final String DB_URL = constants.DB_URL;
    //"jdbc:mysql://127.0.0.1:3306/BuilderGame", "root", "1234"
    //  Database credentials
    static final String USER = constants.USER;
    static final String PASS = constants.PASS;
    private Quest quest;
    private GurnyStaff gurnyStaff = new GurnyStaff();

    public QuestSaver(Quest quest) {
        this.quest = quest;
    }

    public static String getQuestGrades(Quest quest) {
        return (quest.getTeamNumber() + "Quest" + quest.getName() + "Grades").replaceAll(" ", "_");
    }

    public static String getQuestSkills(Quest quest) {
        return (quest.getTeamNumber() + "Quest" + quest.getName() + "Skills").replaceAll(" ", "_");
    }

    public static String getQuestRewards(Quest quest) {
        return (quest.getTeamNumber() + "Quest" + quest.getName() + "Rewards").replaceAll(" ", "_");
    }

    public static String getQuestParty(Quest quest) {
        return (quest.getTeamNumber() + "Quest" + quest.getName() + "Party").replaceAll(" ", "_");
    }

    public void deleteQuest() {
//        delete all the tables
        gurnyStaff.insertUpdateDelete("drop table " + getQuestSkills(quest) + ";");
        gurnyStaff.insertUpdateDelete("drop table " + getQuestRewards(quest) + ";");
        gurnyStaff.insertUpdateDelete("drop table " + getQuestGrades(quest) + ";");
        gurnyStaff.insertUpdateDelete("drop table " + getQuestParty(quest) + ";");
    }

    public void saveQuest() {
//        delete old tables
        deleteQuest();
//        create tables
        gurnyStaff.insertUpdateDelete("create table " + getQuestSkills(quest) + "(name varchar(50), level int);");
        gurnyStaff.insertUpdateDelete("create table " + getQuestRewards(quest) + "(name varchar(50), exp int);");
        gurnyStaff.insertUpdateDelete("create table " + getQuestGrades(quest) + "(grade varchar(10), amount int);");
        gurnyStaff.insertUpdateDelete("create table " + getQuestParty(quest) + "(members varchar(20));");

        for (Map.Entry<Grade, Integer> grade : quest.getGradeRequirments().entrySet()) {
            try {
//                gurnyStaff.insertUpdateDelete("insert into " + getQuestGrades(quest) + " values(\"" + grade.getKey() + "\"," + grade.getValue() + ");");
                gurnyStaff.prepareStatement("insert into " + getQuestGrades(quest) + " values(?,?);");
                gurnyStaff.prepareStatement().setString(1, grade.getKey().toString());
                gurnyStaff.prepareStatement().setInt(2, grade.getValue());
                gurnyStaff.executeUpdate();
            } catch (SQLException ex) {
                Logger.getLogger(QuestSaver.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        for (Map.Entry<Skill, Integer> skill : quest.getSkillRequirments().entrySet()) {
            try {
//                gurnyStaff.insertUpdateDelete("insert into " + getQuestSkills(quest) + " values(\"" + skill.getKey().getName() + "\"," + skill.getValue() + ");");
                gurnyStaff.prepareStatement("insert into " + getQuestSkills(quest) + " values(?,?);");
                gurnyStaff.prepareStatement().setString(1, skill.getKey().getName());
                gurnyStaff.prepareStatement().setInt(2, skill.getValue());
                gurnyStaff.executeUpdate();
            } catch (SQLException ex) {
                Logger.getLogger(QuestSaver.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        for (Map.Entry<Skill, Integer> reward : quest.getRewards().entrySet()) {
            try {
//                gurnyStaff.insertUpdateDelete("insert into " + getQuestRewards(quest) + " values(\"" + reward.getKey().getName() + "\"," + reward.getValue() + ");");
                gurnyStaff.prepareStatement("insert into " + getQuestRewards(quest) + " values(?,?);");
                gurnyStaff.prepareStatement().setString(1, reward.getKey().getName());
                gurnyStaff.prepareStatement().setInt(2, reward.getValue());
                gurnyStaff.executeUpdate();
            } catch (SQLException ex) {
                Logger.getLogger(QuestSaver.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        for (Member m : quest.getParty()) {
            try {
//            gurnyStaff.insertUpdateDelete("insert into " + getQuestParty(quest) + " values(\"" + m.getName() + "\");");
                gurnyStaff.prepareStatement("insert into " + getQuestParty(quest) + " values(?);");
                gurnyStaff.prepareStatement().setString(1, m.getName());
                gurnyStaff.executeUpdate();
            } catch (SQLException ex) {
                Logger.getLogger(QuestSaver.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
}
