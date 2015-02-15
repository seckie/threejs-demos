'use strict'

init = (scene) ->
  pointLight = new THREE.PointLight(0xffffff)
  pointLight.position.x = 10
  pointLight.position.y = 50
  pointLight.position.z = 130
  scene.add(pointLight)

  return pointLight

module.exports = init
