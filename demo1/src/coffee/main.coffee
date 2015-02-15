# From follow tutorial, thanks.
# http://www.johannes-raida.de/tutorials/three.js/tutorial02/tutorial02.htm
#
'use strict'

config = require('./config')
ThreeScene = require('./scene')
ThreeCamera = require('./camera')
ThreeLight = require('./light')
ThreeObject = require('./object')

camera = null
scene = null
renderer = null
object = null


init = (data) ->
  scene = ThreeScene(config)
  camera = ThreeCamera(scene, config)
  #light = ThreeLight(scene)
  object = ThreeObject(scene, config, data)

  $container = document.getElementById('canvas')

  if window.WebGLRenderingContext
    renderer = new THREE.WebGLRenderer(
      antialias: true
    )
  else
    renderer = new THREE.CanvasRenderer()

  #renderer.setSize(config.WIDTH, config.HEIGHT)
  renderer.setSize(window.innerWidth, window.innerHeight)

  # color, opacity
  renderer.setClearColor(0x000000, 1)
  $container.appendChild(renderer.domElement)

  renderer.render(scene, camera)
  return


# initialize
window.addEventListener('load', init, false)

# initialize with some data
#dataUrl = 'data/something.json'
#
#get(dataUrl, (response) ->
#  init(response)
#  #loop()
#)

