using UnityEngine;
using System.Collections;

public class GemSpawner : MonoBehaviour {

    [Range(3, 5)]
    [SerializeField]
    private int _minTimeToSpawn = 5;

    [Range(7, 20)]
    [SerializeField]
    private int _maxTimeToSpawn = 10;

    [SerializeField]
    private GameObject[] _prefabs;

    void Start() {
        StartCoroutine(SpawnGems());
    }

    void Update() {
        
    }

    IEnumerator SpawnGems() {
        while (true) {
            // Spawn the only gem in the column.
            Instantiate(_prefabs[Random.Range(0, _prefabs.Length)], new Vector3(26, Random.Range(-10, 10), 10), Quaternion.identity);
            yield return new WaitForSeconds(Random.Range(_minTimeToSpawn, _maxTimeToSpawn));
        }
    }
}
