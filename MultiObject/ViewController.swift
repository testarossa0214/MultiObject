//
//  ViewController.swift
//  MultiObject
//
//  Created by 柳生宗矩 on 2021/09/06.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sceneView = ARSCNView(frame: self.view.frame)
        self.view.addSubview(self.sceneView)
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene()
        
//        boxの中身の記述。1で1m、chamferRadiusは角の丸み
        let box = SCNBox(width: 0.2, height: 0.2, length: 0.2, chamferRadius: 0)    //boxのオブジェクト生成
        let material = SCNMaterial()             //boxのマテリアルをSCNマテリアルに指定
//        material.diffuse.contents = UIColor.blue //diffuse.contentsで色指定
        material.diffuse.contents = UIImage(named: "brick.jpg")     //マテリアル（表面）の要素を画像に
        
//        Node作成
        let node = SCNNode()
        node.geometry = box                      //形をBOX（四角）に、スフィアで円
        node.geometry?.materials = [material]    //上のマテリアルを呼び出し
        node.position = SCNVector3(0, 0.2, -0.5 ) //3次元空間の座標指定 起動したiphoneから見た位置
        
//        球体部分
        let sphere = SCNSphere(radius: 0.2)      //球体のオブジェクトを作って設定
        let sphereMaterial = SCNMaterial()       //球体のマテリアル(表面)の定義
//        sphereMaterial.diffuse.contents = UIColor.green     //球体の表面の色設定
        sphereMaterial.diffuse.contents = UIImage(named: "earthmap.jpeg")   //球体の方のマテリアル(表面)を画像に
        
//        球体のNode作成
        let sphereNode = SCNNode()
        sphereNode.geometry = sphere             //sphereNodeの形状、ジオメトリー(幾何学模様)を球に指定
        sphereNode.geometry?.materials = [sphereMaterial]    //オプショナル型でsphereMaterialを指定
        sphereNode.position = SCNVector3(0.4, 0.1, -1)       //iphoneの位置からの座標
        
//        作成Nodeを最上位に追加
        scene.rootNode.addChildNode(node)        //一番上のnodeにBoxのNodeを追加
        scene.rootNode.addChildNode(sphereNode)  //一番上のnodeにsphereのNodeを追加
        
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
