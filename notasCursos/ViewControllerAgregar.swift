
import UIKit

class ViewControllerAgregar: UIViewController {
    
    var anteriorVC = ViewController()

    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtPractica: UITextField!
    @IBOutlet weak var txtLaboratorio: UITextField!
    @IBOutlet weak var txtExamen: UITextField!
    @IBAction func btnAgregar(_ sender: Any) {
        if Double(txtPractica.text!)! >= 0.0 && Double(txtPractica.text!)! <= 20.0 && Double(txtLaboratorio.text!)! >= 0.0 && Double(txtLaboratorio.text!)! <= 20.0 && Double(txtExamen.text!)! >= 0.0 && Double(txtExamen.text!)! <= 20.0{
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let curso = Cursos(context: context)
            curso.nombre = txtNombre.text!
            curso.practica = Double(txtPractica.text!)!
            curso.laboratorios = Double(txtLaboratorio.text!)!
            curso.exfinal = Double(txtExamen.text!)!
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            anteriorVC.cursos.append(curso)
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
