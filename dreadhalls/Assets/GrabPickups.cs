using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class GrabPickups : MonoBehaviour {

	private AudioSource pickupSoundSource;

	private bool _isGrabbed = false;

	void Awake() {
		pickupSoundSource = DontDestroy.instance.GetComponents<AudioSource>()[1];
	}

	void OnControllerColliderHit(ControllerColliderHit hit) {
		if (!_isGrabbed && hit.gameObject.tag == "Pickup") {
			pickupSoundSource.Play();
			LevelController.NextLevel();
			SceneManager.LoadScene("Play");

			_isGrabbed = true;
		}
	}
}
