using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class FallingBehaviour : MonoBehaviour {

    [SerializeField]
    private float _destroyPositionThreshold = 0f;

    private bool _isFallen = false;

    private AudioSource _fallingManSound;

    void Start() {
        _fallingManSound = DontDestroy.instance.GetComponents<AudioSource>()[2];
    }

    void Update() {
        float positionY = gameObject.transform.position.y;

        if (!_isFallen && positionY < _destroyPositionThreshold) {
            _fallingManSound.Play();
            SceneManager.LoadScene("GameOver");
            LevelController.ResetLevel();

            _isFallen = true;
        }
    }
}
