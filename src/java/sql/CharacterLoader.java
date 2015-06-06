/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sql;

import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashSet;
import java.util.Set;
import members.Grade;
import members.Member;

/**
 *
 * @author thinkredstone
 */
public class CharacterLoader {

    private Set<Member> characters = new HashSet<>();
    private GurnyStaff gurnyStaff = new GurnyStaff();

    public Set<Member> getCharacters() {
        return characters;
    }
    public Member getMember(String name){
        for(Member m :characters){
            if(m.getName().equalsIgnoreCase(name)){
                return m;
            }
        }
        return null;
    }

    public void readCharacters(int teamNumber) throws SQLException {
        characters = new HashSet<>();
        DatabaseMetaData md = gurnyStaff.getConn().getMetaData();
        ResultSet rs = md.getTables(null, null, "%", null);
        while (rs.next()) {
            Member character = null;
            String currentTable = rs.getString(3);
            if (currentTable.contains("Character") && currentTable.contains(String.valueOf(teamNumber))) {
//              we need to turn underscores to spaces, clear all enum names, and remove charter and skills that signal what his table is in order to get the name.
                String name = currentTable.replaceAll("Character", "").replaceAll("Skills", "").replaceAll("FIFTH", "").replaceAll("SEVENTH", "").replaceAll("EIGHTH", "").replaceAll("_", " ").replaceAll(String.valueOf(teamNumber), "");
//              we need to remove all the above save the enum values in order to get grade; however the name in the tabl has underscores in place of spaces, so we need to fix that
                Grade grade = Grade.valueOf(currentTable.replaceAll(name.replaceAll(" ", "_"), "").replaceAll("Character", "").replaceAll("Skills", "").replaceAll(String.valueOf(teamNumber), ""));
                character = new Member(grade, name, teamNumber);//get rid of all the suffixes
                String[][] skills = gurnyStaff.select("select * from " + CharacterSaver.getCharacterSkills(character));
                for (String[] strings : skills) {
                    character.addSkill(strings[0], Integer.valueOf(strings[1]), Integer.valueOf(strings[2]));
                }

                try {
                    characters.add(character);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }

}
