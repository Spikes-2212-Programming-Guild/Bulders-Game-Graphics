/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package members;

/**
 *
 * @author thinkredstone
 */
public class Skill {

    private String name;
    private int level = 1;
    private int exp = 0;
    private int levelTarget = 10;
    static final int expIncrement = 5;

    public Skill(String name) {
        this.name = name;
    }

    public Skill(String name, int level, int exp) {
        this.name = name;
        if (level > 0) {
            this.level = level;
        }
        if (exp > 0) {
            this.exp = exp;
        }
        levelTarget = levelTarget + expIncrement*(level-1);
        update();
    }

    public int getLevel() {
        return level;
    }

    public void setLevel(int level) {
        this.level = level;
    }

    public String getName() {
        return name;
    }

    public int getExp() {
        return exp;
    }

    public void setExp(int exp) {
        this.exp = exp;
        update();
    }

    public void addExp(int exp) {
        this.exp += exp;
        update();
    }

    private void update() {
        int levelLog;
        do {
            levelLog = level;
            if (exp >= levelTarget) {
                level++;
                exp -= levelTarget;
                levelTarget += expIncrement;
            }
        } while (levelLog != level);
    }

}
