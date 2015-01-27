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

    public void readCharacters() throws SQLException {
        DatabaseMetaData md = gurnyStaff.getConn().getMetaData();
        ResultSet rs = md.getTables(null, null, "%", null);
        while (rs.next()) {
            Member character = null;
            String currentTable = rs.getString(3);
            if (currentTable.contains("Character")) {
                String name = currentTable.replaceAll("Character", "").replaceAll("Skills", "").replaceAll("FIFTH", "").replaceAll("SEVENTH", "").replaceAll("EIGHTH", "");
                Grade grade = Grade.valueOf(currentTable.replaceAll(name, "").replaceAll("Character", "").replaceAll("Skills", ""));
                character = new Member(grade, name);//get rid of all the suffixes
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
