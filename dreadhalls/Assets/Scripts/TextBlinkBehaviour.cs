using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class TextBlinkBehaviour : MonoBehaviour
{
    
    private Text _text;
    private float _elapsedTime;

    [Range(0.1f, 4f)]
    [SerializeField]
    private float _blinkTime = 0.75f;

    void Start() {
        _text = GetComponent<Text>();
    }

    void Update() {
        _elapsedTime += Time.deltaTime;

        if (_elapsedTime >= _blinkTime) {
            OnBlink();
            _elapsedTime = 0;
        }
    }

    void OnBlink() {
        Color currentColor = _text.color;

        if (currentColor.a == 0) {
            _text.color = new Color(currentColor.r, currentColor.g, currentColor.b, 1f);
        } else {
            _text.color = new Color(currentColor.r, currentColor.g, currentColor.b, 0f);
        }
    }
}
