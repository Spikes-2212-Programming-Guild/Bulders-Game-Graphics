/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sql;

import members.Member;
import members.Skill;

/**
 *
 * @author thinkredstone
 */
public class CharacterSaver {

    private Member character;
    private GurnyStaff gurnyStaff = new GurnyStaff();

    public CharacterSaver(Member Character) {
        this.character = Character;
    }

    public static String getCharacterSkills(Member member) {
        return member.getTeamNumber() + "Character" + member.getName().replaceAll(" ", "_") + "Skills" + member.getGrade();
    }

    public void deleteCharacter() {
//        delete the table
        gurnyStaff.insertUpdateDelete("drop table " + getCharacterSkills(character) + ";");
    }

    public void saveCharacter() {
//        delete old table
        deleteCharacter();
//        create table
        gurnyStaff.insertUpdateDelete("create table " + getCharacterSkills(character) + "(name varchar(50), level int, exp int);");
        for (Skill skill : character.getSkills()) {
            gurnyStaff.insertUpdateDelete("insert into " + getCharacterSkills(character) + " values(\"" + skill.getName() + "\"," + skill.getLevel() + "," + skill.getExp() + ");");
        }
    }
}
