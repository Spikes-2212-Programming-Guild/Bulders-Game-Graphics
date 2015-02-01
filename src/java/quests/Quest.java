/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package quests;

import java.util.Collections;
import members.Grade;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import members.Member;
import members.Skill;

/**
 *
 * @author thinkredstone
 */
public class Quest {

    private final String name;
    private Set<Member> party = new HashSet<>();
    private Map<Skill, Integer> skillRequirments = new HashMap<>();
    private Map<Grade, Integer> gradeRequirments = new HashMap<>();
    private Map<Skill, Integer> rewards = new HashMap<>();
    private boolean isDone;

    public Quest(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public Map<Skill, Integer> getRewards() {
        return rewards;
    }

    public Set<Member> getParty() {
        return party;
    }

    public void addSkillRequirment(Skill skill, int level) {
        skillRequirments.put(skill, level);
    }

    public void addGradeRequirment(Grade grade, int count) {
        if (gradeRequirments.get(grade) == null) {
            gradeRequirments.put(grade, count);
        }
    }

    public void addReward(Skill skill, int exp) {
        rewards.put(skill, exp);
    }

    public void addMember(Member m) {
        if (m != null) {
            party.add(m);
        }
    }

    public void removeMember(String name) {
        for (Member m : party) {
            if (m.getName().equalsIgnoreCase(name)) {
                party.remove(m);
            }
        }
    }

    public void removeSkill(String name) {
        Skill log = new Skill(null);
        for (Map.Entry<Skill, Integer> entry: skillRequirments.entrySet()) {
            if(entry.getKey().getName().equalsIgnoreCase(name)){
                log = entry.getKey();
            }
        }
        skillRequirments.remove(log);
    }
    public void removeReward(String name){
        Skill log = new Skill(null);
        for (Map.Entry<Skill, Integer> entry: rewards.entrySet()) {
            if(entry.getKey().getName().equalsIgnoreCase(name)){
                log = entry.getKey();
            }
        }
        rewards.remove(log);
    }

    public Map<Skill, Integer> getSkillRequirments() {
        return Collections.unmodifiableMap(skillRequirments);
    }

    public Map<Grade, Integer> getGradeRequirments() {
        return Collections.unmodifiableMap(gradeRequirments);
    }

    public boolean checkCurrentParty() {
        for (Map.Entry<Grade, Integer> entry : gradeRequirments.entrySet()) {
            int currentGradeCount = 0;
            for (Member member : party) {
                if (member.getGrade().equals(entry.getKey())) {
                    currentGradeCount++;
                }
            }
            if (currentGradeCount < entry.getValue() || currentGradeCount > entry.getValue() + 1) {
                return false;
            }
        }
        boolean partyHasSkillz = false;
        for (Map.Entry<Skill, Integer> entry : skillRequirments.entrySet()) {
            boolean partyHasCurrentSkill = false;
            for (Member member : party) {
                if (member.getSkillLevel(entry.getKey()) >= entry.getValue()) {
                    partyHasCurrentSkill = true;
                    break;
                }
            }
            partyHasSkillz = partyHasCurrentSkill;
            if (!partyHasSkillz) {
                return partyHasSkillz;
            }
        }
        return partyHasSkillz;
    }
}
