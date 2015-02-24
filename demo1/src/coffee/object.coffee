'use strict'

initMesh = (scene, config, dataset) ->
  objects = {}

  boxGeometry = new THREE.BoxGeometry(2.0, 2.0, 2.0)

  texture1 = new THREE.ImageUtils.loadTexture('seckie.png')
  texture1.minFilter = THREE.LinearFilter
  #texture1.magFilter = THREE.LinearFilter
  #texture1.wrapS = THREE.RepeatWrapping
  #texture1.wrapT = THREE.RepeatWrapping
  #texture1.repeat.x = 1
  #texture1.repeat.y = 1
  boxMaterial = new THREE.MeshBasicMaterial(
    map: texture1
    side: THREE.DoubleSide
  )

  boxMesh = new THREE.Mesh(boxGeometry, boxMaterial)
  boxMesh.position.set(0.0, 0.0, 4.0)
  scene.add(boxMesh)
  objects.box = boxMesh

  return objects


init = (scene, config, dataset) ->
  return initMesh(scene, config, dataset)

module.exports = init
