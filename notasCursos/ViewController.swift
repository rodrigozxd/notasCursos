
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var cursos:[Cursos] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.isEditing = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        obtenerData()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cursos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let curso = cursos[indexPath.row]
        let practica =  curso.practica * 0.30
        let laboratorio = curso.laboratorios * 0.70
        let promedio = practica + laboratorio
        if promedio >= 12.5 && promedio <= 20{
            cell.textLabel?.text = "😎 \(curso.nombre!)"
            cell.backgroundColor = UIColor.green
        }else {
            cell.textLabel?.text = "😰 \(curso.nombre!)"
            cell.backgroundColor = UIColor.red
        }
        return cell
    }
    
    //
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            cursos.remove(at: indexPath.row)
            tableView.reloadData()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let eliminar = UIContextualAction(style: .normal , title: "Eliminar") {
            (action, view, completionHandler) in
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let indice = self.cursos[indexPath.row]
            context.delete(indice)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            self.obtenerData()
            self.tableView.reloadData()
            completionHandler(true)
        }
        eliminar.backgroundColor = UIColor.darkGray
        eliminar.image = UIImage(systemName: "trash")
        
        let editar = UIContextualAction(style: .normal , title: "Editar") {
            (action, view, completionHandler) in
            let recuroSeleccionado = self.cursos[indexPath.row]
            self.performSegue(withIdentifier: "segueEditar", sender: recuroSeleccionado)
            completionHandler(true)
        }
        editar.backgroundColor = UIColor.blue
        editar.image = UIImage(systemName: "pencil")
        let swit = UISwipeActionsConfiguration(actions: [eliminar, editar])
        swit.performsFirstActionWithFullSwipe = false
        return swit
    }
    func obtenerData(){
        let conext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            cursos = try conext.fetch(Cursos.fetchRequest()) as! [Cursos]
        } catch {
            print("Error al leer entidad de CoreData")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueAgregar"{
            let siguienteVC = segue.destination as! ViewControllerAgregar
            siguienteVC.anteriorVC = self
        }
        else if segue.identifier == "segueEditar"{
            let siguienteVC = segue.destination as! ViewControllerEditar
            siguienteVC.cursos = (sender as! Cursos)
            siguienteVC.anteriorVC = self
        }
    }
}

