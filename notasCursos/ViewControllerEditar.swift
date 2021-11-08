
import UIKit

class ViewControllerEditar: UIViewController {
    
    var anteriorVC = ViewController()
    var cursos:Cursos? = nil
    
    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtPractica: UITextField!
    @IBOutlet weak var txtLaboratorio: UITextField!
    @IBOutlet weak var txtExamen: UITextField!
    @IBAction func btnEditar(_ sender: Any) {
        if Double(txtPractica.text!)! >= 0.0 && Double(txtPractica.text!)! <= 20.0 && Double(txtLaboratorio.text!)! >= 0.0 && Double(txtLaboratorio.text!)! <= 20.0 && Double(txtExamen.text!)! >= 0.0 && Double(txtExamen.text!)! <= 20.0{
            cursos?.nombre = txtNombre.text!
            cursos?.practica = Double(txtPractica.text!)!
            cursos?.laboratorios = Double(txtLaboratorio.text!)!
            cursos?.exfinal = Double(txtExamen.text!)!
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            anteriorVC.tableView.reloadData()
            navigationController?.popViewController(animated: true)
        }else{
            if Double(txtPractica.text!)! <= 0.0 || Double(txtPractica.text!)! >= 20.0{
                txtPractica.backgroundColor = .systemRed
            }
            if Double(txtLaboratorio.text!)! <= 0.0 || Double(txtLaboratorio.text!)! >= 20.0 {
                txtLaboratorio.backgroundColor = .systemRed
            }
            if Double(txtExamen.text!)! <= 0.0 || Double(txtExamen.text!)! >= 20.0 {
                txtExamen.backgroundColor = .systemRed
            }
            
        }
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        txtNombre.text = cursos!.nombre
        txtPractica.text = String(cursos!.practica)
        txtLaboratorio.text = String(cursos!.laboratorios)
        txtExamen.text = String(cursos!.exfinal)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
