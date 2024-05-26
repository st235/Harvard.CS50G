using UnityEngine;
using System.Collections;

public class Gem : MonoBehaviour {

    private static float DespawnPositionX = -25f;
    private static float RotationSpeedY = 5f;

    void Start() {

    }

    void Update() {
        if (transform.position.x < DespawnPositionX) {
            Destroy(gameObject);
        }

        transform.Translate(-SkyscraperSpawner.CurrentSpeed * Time.deltaTime, 0f, 0f, Space.World);
        transform.Rotate(0f, RotationSpeedY, 0f, Space.World);
    }

	void OnTriggerEnter(Collider other) {
		other.transform.parent.GetComponent<HeliController>().PickupGem();
		Destroy(gameObject);
	}
}
