package view;

import java.awt.EventQueue;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
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
import javax.swing.UIManager;
import javax.swing.UnsupportedLookAndFeelException;
import javax.swing.border.EmptyBorder;

import dao.GenericDAO;
import javax.swing.JTextField;

public class TelaApuracao extends JFrame implements ActionListener {

	private static final long serialVersionUID = 1L;
	private JPanel contentPane;
	// ComboBox que vai mostrar as escolas de samba disponíveis
	private static JComboBox<String> cbbxEscolas; 
	// Botão que vai inserir as notas das escolas no banco de dados
	private JButton btnInserir; 
	// Contadores para controlar a passagem dos quesitos e dos jurados
	private static int contador = 0, contador2 = 0, contador3 = 0, contador4 = 0;
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
	// Ainda em avaliação...
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
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	public TelaApuracao() {
		super("Apuração");
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 483, 320);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);
		
		JLabel lblEscola = new JLabel("Escola");
		lblEscola.setBounds(26, 30, 46, 14);
		contentPane.add(lblEscola);
		
		cbbxEscolas = new JComboBox<String>();
		cbbxEscolas.setBounds(82, 26, 358, 22);
		contentPane.add(cbbxEscolas);
		
		btnInserir = new JButton("Inserir");
		btnInserir.addActionListener(this);
		btnInserir.setBounds(196, 194, 113, 28);
		contentPane.add(btnInserir);
		
		JLabel lblQuesito = new JLabel("Quesito");
		lblQuesito.setBounds(26, 110, 46, 14);
		contentPane.add(lblQuesito);
		
		cbbxQuesitos = new JComboBox<String>();
		cbbxQuesitos.setBounds(82, 106, 358, 22);
		contentPane.add(cbbxQuesitos);		
		
		JLabel lblJurado = new JLabel("Jurado");
		lblJurado.setBounds(26, 68, 55, 16);
		contentPane.add(lblJurado);
		
		cbbxJurados = new JComboBox<String>();
		cbbxJurados.setBounds(82, 68, 358, 22);
		contentPane.add(cbbxJurados);
		
		JLabel lblNota = new JLabel("Nota");
		lblNota.setBounds(26, 200, 55, 16);
		contentPane.add(lblNota);
		
		txtNota = new JTextField();
		txtNota.setBounds(70, 194, 91, 28);
		contentPane.add(txtNota);
		txtNota.setColumns(10);
		
		btnVerQuesito = new JButton("Ver Quesito");
		btnVerQuesito.setBounds(196, 234, 113, 28);
		contentPane.add(btnVerQuesito);
		
		btnVerTotal = new JButton("Ver Total");
		btnVerTotal.setBounds(321, 234, 113, 28);
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
			/*
			 * Descrição dos contadores:
			 * 
			 * contador -> faz o loop do nome das escolas de samba no cbbxEscolas
			 * contador2 -> faz o loop das 5 notas para cada quesito
			 * contador3 -> faz o loop do nome dos quesitos no cbbxQuesitos 
			 * contador4 -> faz o loop do nome dos jurados no cbbxJurados
			 */
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
				contador2++;
				contador4++;
				cbbxJurados.setSelectedIndex(contador4);
				if (contador2 == 5) {
					contador2 = 0;
					contador3++;
					cbbxQuesitos.setSelectedIndex(contador3);
				}
			}	
			// Printa no console a situação atual dos contadores 
			System.out.println("cont1 = " + contador + " | cont2 = " + contador2 + " | cont3 = " + contador3 + 
					" | cont4 = " + contador4);
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
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		for (String quesito : quesitos) {
			cbbxQuesitos.addItem(quesito);
		}
	}
	
	public static void carregarJurados(){
		String sql = "SELECT jurado.nome FROM quesito_jurado " +
				"INNER JOIN jurado " +
				"ON quesito_jurado.id_jurado = jurado.id_jurado " +
				"ORDER BY id_quesito, ordem";
		try {
			PreparedStatement stmt = generic.getConnection().prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();
			// Adiciona à List os nomes dos jurados contidos na tabela jurado
			while(rs.next()){
				jurados.add(rs.getString(1));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		for (String jurado : jurados) {
			cbbxJurados.addItem(jurado);
		}
	}
}
