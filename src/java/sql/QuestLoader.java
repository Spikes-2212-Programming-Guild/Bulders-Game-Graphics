/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sql;

import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import members.Grade;
import members.Skill;
import quests.Quest;

/**
 *
 * @author thinkredstone
 */
public class QuestLoader {

    private Set<Quest> quests = new HashSet<>();
    private GurnyStaff gurnyStaff = new GurnyStaff();
    private List<String> questsLoaded = new ArrayList<>();

    public Set<Quest> getQuests() {
        return quests;
    }
    public Quest getQuest(String name){
        for(Quest q:quests){
            if(q.getName().equalsIgnoreCase(name)){
                return q;
            }
        }
        return null;
    }

    public void readQuests() throws SQLException {
        CharacterLoader cl = new CharacterLoader();
        cl.readCharacters();
        DatabaseMetaData md = gurnyStaff.getConn().getMetaData();
        ResultSet rs = md.getTables(null, null, "%", null);
        while (rs.next()) {
            Quest quest = null;
            String currentTable = rs.getString(3);
            if (currentTable.contains("Quest")) {
                quest = new Quest(currentTable.replaceAll("Quest", "").replaceAll("Grades", "").replaceAll("Skills", "").replaceAll("Rewards", ""));//get rid of all the suffixes
                if (!questsLoaded.contains(quest.getName())) {
                    questsLoaded.add(quest.getName());
                    String[][] grades = gurnyStaff.select("select * from " + QuestSaver.getQuestGrades(quest));
                    String[][] skills = gurnyStaff.select("select * from " + QuestSaver.getQuestSkills(quest));
                    String[][] rewards = gurnyStaff.select("select * from " + QuestSaver.getQuestRewards(quest));
                    String[][] party = gurnyStaff.select("select * from " + QuestSaver.getQuestParty(quest));
                    for (String[] strings : grades) {
                        quest.addGradeRequirment(Grade.valueOf(strings[0]), Integer.valueOf(strings[1]));
                    }
                    for (String[] strings : skills) {
                        quest.addSkillRequirment(new Skill(strings[0]), Integer.valueOf(strings[1]));
                    }
                    for (String[] strings : rewards) {
                        quest.addReward(new Skill(strings[0]), Integer.valueOf(strings[1]));
                    }
                    for(String[] strings : party){
                        quest.addMember(cl.getMember(strings[0]));
                    }
                    try {
                        quests.add(quest);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        }

    }
}
