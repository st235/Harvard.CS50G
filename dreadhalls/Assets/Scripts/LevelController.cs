using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

[RequireComponent(typeof(Text))]
public class LevelController : MonoBehaviour {

    private static int CurrentLevel = 1;

    public static void NextLevel() {
        CurrentLevel++;
    }

    public static void ResetLevel() {
        CurrentLevel = 1;
    }
    
    private Text _levelText;

    void Start() {
        _levelText = GetComponent<Text>();
        _levelText.text = "Level: " + CurrentLevel;
    }
}
