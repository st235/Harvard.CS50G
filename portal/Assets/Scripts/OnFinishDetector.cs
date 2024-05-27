using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class OnFinishDetector : MonoBehaviour {

    [SerializeField]
    private Text _finalText;

    private void OnTriggerEnter(Collider other) {
        if (other.tag == "Finish") {
            Debug.Log("Hello world!");

            _finalText.enabled = true;
        }
    }
}
