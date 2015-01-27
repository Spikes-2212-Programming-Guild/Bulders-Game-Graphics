/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package members;

import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

/**
 *
 * @author thinkredstone
 */
public class Member {

    private Grade grade;
    private final String name;
    private Set<Skill> skills = new HashSet<>();

    public Member(Grade grade, String name) {
        this.grade = grade;
        this.name = name;
    }

    public void addSkill(Skill s) {
        skills.add(s);
    }

    public void addSkill(String name, int level, int exp) {
        skills.add(new Skill(name, level, exp));
    }

    public Grade getGrade() {
        return grade;
    }

    public String getName() {
        return name;
    }

    public Set<Skill> getSkills() {
        return Collections.unmodifiableSet(skills);
    }

    public int getSkillLevel(String name) {
        for (Skill s : skills) {
            if (s.getName().equalsIgnoreCase(name)) {
                return s.getLevel();
            }
        }
        return 0;
    }
    public int getSkillLevel(Skill skill) {
        for (Skill s : skills) {
            if (s.getName().equalsIgnoreCase(skill.getName())) {
                return s.getLevel();
            }
        }
        return 0;
    }

    public void addExp(String skillName, int exp) {
        for (Skill s : skills) {
            if (s.getName().equalsIgnoreCase(skillName)) {
                s.addExp(exp);
            }
        }
    }

}
