'use strict'

initMesh = (scene, config, dataset) ->
  objects = {}

#   triangleGeometry = new THREE.Geometry()
#   triangleGeometry.vertices.push(new THREE.Vector3(0.0, 1.0, 0.0))
#   triangleGeometry.vertices.push(new THREE.Vector3(-1.0, -1.0, 0.0))
#   triangleGeometry.vertices.push(new THREE.Vector3(1.0, -1.0, 0.0))
#   triangleGeometry.faces.push(new THREE.Face3(0, 1, 2))
#   triangleGeometry.faces[0].vertexColors[0] = new THREE.Color(0xff0000)
#   triangleGeometry.faces[0].vertexColors[1] = new THREE.Color(0x00ff00)
#   triangleGeometry.faces[0].vertexColors[2] = new THREE.Color(0x0000ff)

  pyramidGeometry = new THREE.CylinderGeometry(0, 1.5, 1.5, 4, false)
  pyramidGeometry.faces.map((face, i) ->
    if face instanceof THREE.Face4
      face.VertexColors[0] = new THREE.Color(0xff0000)
      if i % 2 is 0
        face.vertexColors[1] = new THREE.Color(0x00ff00)
        face.vertexColors[2] = new THREE.Color(0x0000ff)
      else
        face.vertexColors[1] = new THREE.Color(0x0000ff)
        face.vertexColors[2] = new THREE.Color(0x00ff00)
      face.vertexColors[3] = new THREE.Color(0xff0000)
    else
      face.vertexColors[0] = new THREE.Color(0xff0000)
      face.vertexColors[1] = new THREE.Color(0x00ff00)
      face.vertexColors[2] = new THREE.Color(0x0000ff)

  )
  pyramidMaterial = new THREE.MeshBasicMaterial(
    vertexColors: THREE.VertexColors
    side: THREE.DoubleSide
  )
  pyramidMesh = new THREE.Mesh(pyramidGeometry, pyramidMaterial)
  pyramidMesh.position.set(-1.5, 0.0, 4.0)
  scene.add(pyramidMesh)

  objects.pyramid = pyramidMesh


  boxGeometry = new THREE.BoxGeometry(1.5, 1.5, 1.5)
  boxMaterials = [
    new THREE.MeshBasicMaterial( color: 0xff0000 )
    new THREE.MeshBasicMaterial( color: 0x00ff00 )
    new THREE.MeshBasicMaterial( color: 0x0000ff )
    new THREE.MeshBasicMaterial( color: 0xffff00 )
    new THREE.MeshBasicMaterial( color: 0x00ffff )
    new THREE.MeshBasicMaterial( color: 0xffffff )
  ]
  boxMaterial = new THREE.MeshFaceMaterial(boxMaterials)
  boxMesh = new THREE.Mesh(boxGeometry, boxMaterial)
  boxMesh.position.set(1.5, 0.0, 4.0)
  scene.add(boxMesh)
  objects.box = boxMesh

  return objects


init = (scene, config, dataset) ->
  return initMesh(scene, config, dataset)

module.exports = init
