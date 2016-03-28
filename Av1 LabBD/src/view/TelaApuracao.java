package view;

import java.awt.Color;
import java.awt.EventQueue;
import java.awt.Font;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.swing.UIManager;
import javax.swing.UnsupportedLookAndFeelException;
import javax.swing.border.EmptyBorder;

import dao.GenericDAO;

public class TelaApuracao extends JFrame implements ActionListener {

	private static final long serialVersionUID = 1L;
	private JPanel contentPane;
	// ComboBox que vai mostrar as escolas de samba disponíveis
	private static JComboBox<String> cbbxEscolas; 
	// Botão que vai inserir as notas das escolas no banco de dados
	private JButton btnInserir; 
	// Contadores para controlar a passagem dos quesitos e dos jurados
	private static int contador = 0, contador2 = 0, contador3 = 0,
					   contador4 = 0, contador5 = 1, contador6 = 0;
	// Lista que vai conter os dados da tabela escola_de_samba para serem carregados para o ComboBox - cbbxEscolas
	private static List<String> escolas = new ArrayList<String>();
	// Classe que faz a conexão com o banco de dados av1_lab_bd
	private static GenericDAO generic = new GenericDAO();
	// ComboBox que vai mostrar os quesitos disponíveis
	private static JComboBox<String> cbbxQuesitos;
	// Lista que vai conter os dados da tabela quesito para serem carregados para o ComboBox - cbbxQuesitos
	private static List<String> quesitos = new ArrayList<String>();
	// TextField que vai receber a nota para cada escola de samba em um dos quesitos, segundo algum jurado
	private JTextField txtNota;
	// ComboBox que vai mostrar os jurados
	private static JComboBox<String> cbbxJurados;
	// Lista que vai conter os dados da tabela quesito_jurado para serem carregados para o ComboBox - cbbxJurados
	private static List<String> jurados = new ArrayList<String>();
	private JButton btnVerQuesito;
	private JButton btnVerTotal;

	public static void main(String[] args) {
		try {
			// Comando para a alteração do layout dos componentes da View - TelaApuracao
			UIManager.setLookAndFeel("javax.swing.plaf.nimbus.NimbusLookAndFeel");
		} catch (ClassNotFoundException e1) {
			e1.printStackTrace();
		} catch (InstantiationException e1) {
			e1.printStackTrace();
		} catch (IllegalAccessException e1) {
			e1.printStackTrace();
		} catch (UnsupportedLookAndFeelException e1) {
			e1.printStackTrace();
		}
		
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					TelaApuracao frame = new TelaApuracao();
					frame.setVisible(true);
					// Comando para centralização da tela
					frame.setLocationRelativeTo(null);
					// Comando para não permitir a maximização da tela
					frame.setResizable(false);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	public TelaApuracao() {
		super("Apuração");
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 523, 320);		
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);
		
		JLabel lblEscola = new JLabel("Escola");
		lblEscola.setFont(new Font("SansSerif", Font.BOLD, 13));
		lblEscola.setBounds(39, 30, 46, 14);
		contentPane.add(lblEscola);
		
		cbbxEscolas = new JComboBox<String>();
		cbbxEscolas.setBackground(new Color(26, 188, 156));
		cbbxEscolas.setBounds(115, 26, 358, 22);
		contentPane.add(cbbxEscolas);
		
		btnInserir = new JButton("Inserir");
		btnInserir.setBackground(new Color(230, 126, 34));
		btnInserir.addActionListener(this);
		btnInserir.setBounds(229, 194, 113, 28);
		contentPane.add(btnInserir);
		
		JLabel lblQuesito = new JLabel("Quesito");
		lblQuesito.setFont(new Font("SansSerif", Font.BOLD, 13));
		lblQuesito.setBounds(39, 110, 78, 14);
		contentPane.add(lblQuesito);
		
		cbbxQuesitos = new JComboBox<String>();
		cbbxQuesitos.setBackground(new Color(26, 188, 156));
		cbbxQuesitos.setBounds(115, 106, 358, 22);
		contentPane.add(cbbxQuesitos);		
		
		JLabel lblJurado = new JLabel("Jurado");
		lblJurado.setFont(new Font("SansSerif", Font.BOLD, 13));
		lblJurado.setBounds(39, 71, 55, 16);
		contentPane.add(lblJurado);
		
		cbbxJurados = new JComboBox<String>();
		cbbxJurados.setBackground(new Color(26, 188, 156));
		cbbxJurados.setBounds(115, 68, 358, 22);
		contentPane.add(cbbxJurados);
		
		JLabel lblNota = new JLabel("Nota");
		lblNota.setFont(new Font("SansSerif", Font.BOLD, 13));
		lblNota.setBounds(50, 200, 55, 16);
		contentPane.add(lblNota);
		
		txtNota = new JTextField();
		txtNota.setBounds(103, 194, 91, 28);
		contentPane.add(txtNota);
		txtNota.setColumns(10);
		
		btnVerQuesito = new JButton("Ver Quesito");
		btnVerQuesito.setBackground(new Color(52, 152, 219));
		btnVerQuesito.addActionListener(this);
		btnVerQuesito.setBounds(229, 234, 113, 28);
		contentPane.add(btnVerQuesito);
		
		btnVerTotal = new JButton("Ver Total");
		btnVerTotal.setBackground(new Color(52, 152, 219));
		btnVerTotal.addActionListener(this);
		btnVerTotal.setBounds(354, 234, 113, 28);
		contentPane.add(btnVerTotal);
		
		carregarEscolas();
		carregarJurados();
		carregarQuesitos();		
	}

	public void actionPerformed(ActionEvent evento) {		
		// Pega o nome do botão que foi pressionado
		String comando = evento.getActionCommand();
		// Verifica se o botão inserir foi pressionado
		if (comando.equals("Inserir")) {
			double nota = 0;
			// Verifica se o campo nota está vazio
			if (txtNota.getText().equals("")) {
				JOptionPane.showMessageDialog(null, "O campo nota não pode estar vazio!",
						"ERRO", JOptionPane.ERROR_MESSAGE);
			} else {
				nota = Double.parseDouble(txtNota.getText());
				// Verifica se a nota está no intervalo de 5.0 à 10.0
				if (nota < 5.0 || nota > 10.0) {
					JOptionPane.showMessageDialog(null, "Nota inválida!\n\n"
							+ "Digite outra nota novamente!\n\n"
							+ "OBS: Notas devem estar no intervalo de 5.0 à 10.0.", 
							"ERRO", JOptionPane.ERROR_MESSAGE);	
					txtNota.setText("");
				} else {
					nota = Double.parseDouble(txtNota.getText());
					txtNota.setText("");
					/*
					 * Descrição dos contadores:
					 * 
					 * contador -> faz o loop do nome das escolas de samba no cbbxEscolas
					 * contador2 -> faz o loop das 5 notas para cada quesito
					 * contador3 -> faz o loop do nome dos quesitos no cbbxQuesitos 
					 * contador4 -> faz o loop do nome dos jurados no cbbxJurados
					 * contador5 -> faz o loop do id dos quesitos
					 */
					
					contador6++;
					contador++;					
					
					cbbxEscolas.setSelectedIndex(contador);
					if (contador == 13) {
						contador = - 1;
						// If que define o término da apuração
						if (contador == -1 && contador2 == 4 && contador3 == 8) {
							JOptionPane.showMessageDialog(null, "A apuração acabou!");
							btnInserir.setEnabled(false);
						}					
					} else if(contador == 0) {							
						contador4++;					
						cbbxJurados.setSelectedIndex(contador4);				
					}					
					
					if (contador5 == 15) {
						contador5 = 1;
						contador2++;
					}					
					
					// Printa no console a situação atual dos contadores 
					System.out.println("cont1 = " + contador + " | cont2 = " + contador2 + " | cont3 = " + contador3 + 
							" | cont4 = " + contador4 + " | cont5 = " + contador5 + " | cont6 = " + contador6);				
					
					/*
					 * Faz a chamada da stored procedure sp_apuracao
					 */
					String sqlCall = "{call sp_apuracao(?,?,?,?)}";
					try {
						CallableStatement cs = generic.getConnection().prepareCall(sqlCall);
						cs.setInt(1, contador3);
						cs.setInt(2, contador5);
						cs.setDouble(3, nota);
						cs.setInt(4, contador2);
						cs.execute();
						
						cs.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
					
					if (contador6 == 70) {
						contador6 = 0;
						contador3++;
						cbbxQuesitos.setSelectedIndex(contador3);
						contador2 = -1;
					}
					
					contador5++;
				}
			}			
		} else if (comando.equals("Ver Quesito")) {
			// Cria uma nova janela e configura o título de acordo com o quesito em apuração
			TelaVerQuesito tvq = new TelaVerQuesito(quesitos.get(contador3).toString());
			tvq.setVisible(true);
			tvq.setLocationRelativeTo(null);
			tvq.setResizable(false);
		} else if (comando.equals("Ver Total")) {
			TelaVerTotal tvt = new TelaVerTotal();
			tvt.setVisible(true);
			tvt.setLocationRelativeTo(null);
			tvt.setResizable(false);
		}
	}
	
	public static void carregarEscolas(){
		String sql = "SELECT nome FROM escola_de_samba";
		try {
			PreparedStatement stmt = generic.getConnection().prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();
			// Adiciona à List os nomes das escolas de samba contidas na tabela escola_de_samba
			while (rs.next()) {
				escolas.add(rs.getString(1));
			}
			
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		for (String escola : escolas) {
			cbbxEscolas.addItem(escola);
		}
	}
	
	public static void carregarQuesitos(){
		String sql = "SELECT nome FROM quesito";
		try {
			PreparedStatement stmt = generic.getConnection().prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();
			// Adiciona à List os nomes dos quesitos contidos na tabela quesito
			while(rs.next()){
				quesitos.add(rs.getString(1));
			}
			
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		for (String quesito : quesitos) {
			cbbxQuesitos.addItem(quesito);
		}
	}
	
	public static void carregarJurados(){
		// Pensar em dar um SELECT em uma VIEW?
		String sql = "SELECT * FROM view_quesito_jurado";
		try {
			PreparedStatement stmt = generic.getConnection().prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();
			// Adiciona à List os nomes dos jurados contidos na tabela jurado
			while(rs.next()){
				jurados.add(rs.getString(1));
			}
			
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		for (String jurado : jurados) {
			cbbxJurados.addItem(jurado);
		}
	}
}
