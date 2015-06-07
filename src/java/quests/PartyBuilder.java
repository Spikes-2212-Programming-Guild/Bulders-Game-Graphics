/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package quests;

import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import members.Grade;
import members.Member;
import members.Skill;

/**
 *
 * @author thinkredstone
 */
public class PartyBuilder {

    Quest quest;
    Set<Member> members5 = new HashSet<>();
    Set<Member> members7 = new HashSet<>();
    Set<Member> members8 = new HashSet<>();

    public PartyBuilder(Quest quest, Set<Member> members) {
        this.quest = quest;
        for (Member m : members) {
            if (m.getGrade().equals(Grade.FIFTH)) {
                members5.add(m);
            }
            if (m.getGrade().equals(Grade.SEVENTH)) {
                members7.add(m);
            }
            if (m.getGrade().equals(Grade.EIGHTH)) {
                members8.add(m);
            }
        }
    }

    public void addBestSuited(Set<Member> members) {
        Member bestSuited = new Member(null, null, 0);
        int bestSuitness = Integer.MAX_VALUE;
        for (Member member : members) {
            int currentSuitness = 0;
            for (Map.Entry<Skill, Integer> skill : quest.getSkillRequirments().entrySet()) {//we just want them to be close
                currentSuitness += member.getSkillLevel(skill.getKey()) - quest.getSkillRequirments().get(skill.getKey());//updates the current suitness according ot the diffrence between requirment and level
            }
            if (currentSuitness < bestSuitness) {
                bestSuited = member;
                bestSuitness = currentSuitness;
            }
        }
//        for (Member member : members) {
//            if (Math.abs(member.getSkillLevel(skill) - level) < Math.abs(bestSuited.getSkillLevel(skill) - level)
//                    && member.getSkillLevel(skill) >= level) {
//                bestSuited = member;
//            }
//        }
        if (bestSuited.getName() != null) {
            quest.addMember(bestSuited);
            members.remove(bestSuited);
        }
    }

    public void addBestSuitedAbove(Set<Member> members) {
        Member bestSuited = new Member(null, null, 0);
        int bestSuitness = Integer.MAX_VALUE;
        for (Member member : members) {
            int currentSuitness = 0;
            for (Map.Entry<Skill, Integer> skill : quest.getSkillRequirments().entrySet()) {//we just want them to be close
                if (member.getSkillLevel(skill.getKey()) >= skill.getValue()) {//need to be above or the same as the requirments
                    currentSuitness += member.getSkillLevel(skill.getKey()) - quest.getSkillRequirments().get(skill.getKey());//updates the current suitness according ot the diffrence between requirment and level
                } else {
                    currentSuitness = Integer.MAX_VALUE;//lower then the requirments, not suited at all
                    break;//dodge int overflow
                }
            }
            if (currentSuitness < bestSuitness) {
                bestSuited = member;
                bestSuitness = currentSuitness;
            }
        }
        if (bestSuited.getName() != null) {
            quest.addMember(bestSuited);
            members.remove(bestSuited);
        }
    }

    public void addLeastSkilled(Set<Member> members) {
        Member leastSkilled = new Member(null, null, 0);
        int skillTotal = Integer.MAX_VALUE;
        for (Member member : members) {
            int currentSkillTotal = 0;
            for (Map.Entry<Skill, Integer> skill : quest.getSkillRequirments().entrySet()) {//we just want them to be close
                currentSkillTotal += member.getSkillLevel(skill.getKey()) - skill.getValue();//updates the current skill total according ot the diffrence between level and requirment
            }
            if (currentSkillTotal < skillTotal) {
                leastSkilled = member;
                skillTotal = currentSkillTotal;
            }
        }
        if (leastSkilled.getName() != null) {
            quest.addMember(leastSkilled);
            members.remove(leastSkilled);
        }
    }

    public void buildParty() {
        quest.getParty().clear();
        boolean hasPartyLeader = false;
        boolean partyLeaderIsSeventh = false;
        if (quest.getGradeRequirments().get(Grade.EIGHTH) != null) {
            if (quest.getGradeRequirments().get(Grade.EIGHTH) > 0 && !members8.isEmpty()) {//handles setting an eigth as a party leader and flags doing so
                addBestSuitedAbove(members8);
                hasPartyLeader = true;
                for (int i = 0; i < quest.getGradeRequirments().get(Grade.EIGHTH) - 1; i++) {
                    addBestSuited(members8);
                }
            }
        }
        if (quest.getGradeRequirments().get(Grade.SEVENTH) != null) {
            if (quest.getGradeRequirments().get(Grade.SEVENTH) > 0 && !members7.isEmpty() && !hasPartyLeader) {
                addBestSuitedAbove(members7);
                hasPartyLeader = true;
                partyLeaderIsSeventh = true;
            }

            if (partyLeaderIsSeventh) {
                for (int i = 0; i < quest.getGradeRequirments().get(Grade.SEVENTH) - 1; i++) {
                    addBestSuited(members7);
                }
            } else {
                for (int i = 0; i < quest.getGradeRequirments().get(Grade.SEVENTH); i++) {
                    addBestSuited(members7);
                }
            }
        }
        if (quest.getGradeRequirments().get(Grade.FIFTH) != null) {
            for (int i = 0; i < quest.getGradeRequirments().get(Grade.FIFTH); i++) {
                addLeastSkilled(members5);
            }
        }
    }

}
