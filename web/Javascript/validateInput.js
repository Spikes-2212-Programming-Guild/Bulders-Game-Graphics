/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


function validateWord(word, sigma) {
    var flag = true;
    for (var i = 0; i < word.length; i++) {
        if (sigma.indexOf(word[i]) === -1) {
            flag = false;
            alert("Invalid input! Character '" + word[i] + "' is invalid!")
            break;
        }
    }
    return flag;
}

var numbers = '1234567890';
var LowerCaseLetters = 'qertyuiopadfghjklzxcvbnm';
var UpperCaseLetters = 'QWERTYUIOPASDFGHJKLZXCVBNM';
var SpecialChars = ' ';//spaces are a char too!

function validate(word) {
    return validateWord(word, (numbers + LowerCaseLetters + SpecialChars + UpperCaseLetters));
}

function validateNumbers(word) {
    return validateWord(word, numbers);
}