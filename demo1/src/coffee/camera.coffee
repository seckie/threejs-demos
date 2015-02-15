'use strict'
config = require('./config')

init = (scene, config)->
  camera = new THREE.PerspectiveCamera(45, window.innerWidth / window.innerHeight, 1, 100)
  camera.position.set(0, 0, 10)
  camera.lookAt(scene.position)
  scene.add(camera)
  return camera

module.exports = init
