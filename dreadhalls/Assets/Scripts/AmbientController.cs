using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AmbientController : MonoBehaviour
{
    
    private DontDestroy _ambientMusicSource;

    void Start() {
        _ambientMusicSource = DontDestroy.instance;

        if (_ambientMusicSource != null) {
            Destroy(_ambientMusicSource.gameObject);
        }
    }
}
