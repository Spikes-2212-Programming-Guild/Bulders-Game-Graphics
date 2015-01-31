/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sql;

import java.util.Map;
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
        return "Quest" + quest.getName() + "Grades";
    }

    public static String getQuestSkills(Quest quest) {
        return "Quest" + quest.getName() + "Skills";
    }

    public static String getQuestRewards(Quest quest) {
        return "Quest" + quest.getName() + "Rewards";
    }

    public static String getQuestParty(Quest quest) {
        return "Quest" + quest.getName() + "Party";
    }

    public void saveQuest() {
//        delete old tables
        gurnyStaff.insertUpdateDelete("drop table " + getQuestSkills(quest) + ";");
        gurnyStaff.insertUpdateDelete("drop table " + getQuestRewards(quest) + ";");
        gurnyStaff.insertUpdateDelete("drop table " + getQuestGrades(quest) + ";");
        gurnyStaff.insertUpdateDelete("drop table " + getQuestParty(quest) + ";");
//        create tables
        gurnyStaff.insertUpdateDelete("create table " + getQuestSkills(quest) + "(name varchar(50), level int);");
        gurnyStaff.insertUpdateDelete("create table " + getQuestRewards(quest) + "(name varchar(50), exp int);");
        gurnyStaff.insertUpdateDelete("create table " + getQuestGrades(quest) + "(grade varchar(10), amount int);");
        gurnyStaff.insertUpdateDelete("create table " + getQuestParty(quest) + "(members varchar(20)");

        for (Map.Entry<Grade, Integer> grade : quest.getGradeRequirments().entrySet()) {
            gurnyStaff.insertUpdateDelete("insert into " + getQuestGrades(quest) + " values(\"" + grade.getKey() + "\"," + grade.getValue() + ");");
        }
        for (Map.Entry<Skill, Integer> skill : quest.getSkillRequirments().entrySet()) {
            gurnyStaff.insertUpdateDelete("insert into " + getQuestSkills(quest) + " values(\"" + skill.getKey().getName() + "\"," + skill.getValue() + ");");
        }
        for (Map.Entry<Skill, Integer> reward : quest.getRewards().entrySet()) {
            gurnyStaff.insertUpdateDelete("insert into " + getQuestRewards(quest) + " values(\"" + reward.getKey().getName() + "\"," + reward.getValue() + ");");
        }
        for (Member m : quest.getParty()) {
            gurnyStaff.insertUpdateDelete("insert into " + getQuestParty(quest) + " values(\"" + m.getName() + "\");");
        }
    }
}
