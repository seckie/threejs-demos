# From following tutorial. Thanks.
# http://www.johannes-raida.de/tutorials.htm
'use strict'

config = require('./config')
ThreeScene = require('./scene')
ThreeCamera = require('./camera')
ThreeLight = require('./light')
ThreeObjects = require('./object')

camera = null
scene = null
renderer = null
objects = null


init = (data) ->
  scene = ThreeScene(config)
  camera = ThreeCamera(scene, config)
  #light = ThreeLight(scene)
  objects = ThreeObjects(scene, config, data)

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

  animateScene()

renderScene = () ->
  renderer.render(scene, camera)
  return

animateScene = () ->
  objects.triangle.rotation.y += 0.1
  objects.square.rotation.x -= 0.075
  requestAnimationFrame(animateScene)
  renderScene()
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

