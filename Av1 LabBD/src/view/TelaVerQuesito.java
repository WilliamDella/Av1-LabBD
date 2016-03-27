package view;

import java.awt.EventQueue;
import java.awt.Font;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.UIManager;
import javax.swing.UnsupportedLookAndFeelException;
import javax.swing.border.EmptyBorder;
import javax.swing.table.DefaultTableModel;

import dao.GenericDAO;
import model.Quesito;

public class TelaVerQuesito extends JFrame {

	private static final long serialVersionUID = 1L;
	private JPanel contentPane;
	private static JTable tabelaVerQuesitos;
	private JLabel label;
	private final static DefaultTableModel modelo = new DefaultTableModel();
	private static GenericDAO generic = new GenericDAO();
	private String[] nomesColunas = {"Escola de Samba", "Nota 1", "Nota 2", "Nota 3",
			"Nota 4", "Nota 5", "Menor Descartada", "Maior Descartada", "Nota Total"};
	private static int contador = 0;
	
	public static void main(String[] args) {
		try {
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
					TelaVerQuesito frame = new TelaVerQuesito(null);
					frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}
	
	public TelaVerQuesito(String titulo) {
		super("Quesito - " + titulo);
		setBounds(100, 100, 1068, 521);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);
		
		JScrollPane scrollPane = new JScrollPane();
		scrollPane.setBounds(6, 56, 1048, 432);
		contentPane.add(scrollPane);
		
		if(contador == 0){
			for (String coluna : nomesColunas) {
				modelo.addColumn(coluna);
			}
		} else {
			for (int i = modelo.getRowCount() - 1; i > -1; i--) {
		        modelo.removeRow(i);
		    }
		}
		
		contador++;
		
		carregaTabelaVerQuesito(titulo);		
		
		tabelaVerQuesitos = new JTable();
		tabelaVerQuesitos.setModel(modelo);
		tabelaVerQuesitos.setRowHeight(25);
		tabelaVerQuesitos.getColumnModel().getColumn(0).setPreferredWidth(150);
		tabelaVerQuesitos.getColumnModel().getColumn(1).setPreferredWidth(15);
		tabelaVerQuesitos.getColumnModel().getColumn(2).setPreferredWidth(15);
		tabelaVerQuesitos.getColumnModel().getColumn(3).setPreferredWidth(15);
		tabelaVerQuesitos.getColumnModel().getColumn(4).setPreferredWidth(15);
		tabelaVerQuesitos.getColumnModel().getColumn(5).setPreferredWidth(15);		
		scrollPane.setViewportView(tabelaVerQuesitos);
		
		JLabel lblQuesitoAtual = new JLabel("Quesito Atual: ");
		lblQuesitoAtual.setFont(new Font("SansSerif", Font.BOLD, 16));
		lblQuesitoAtual.setBounds(26, 18, 144, 16);
		contentPane.add(lblQuesitoAtual);
		
		label = new JLabel(titulo);
		label.setFont(new Font("SansSerif", Font.PLAIN, 15));
		label.setBounds(158, 18, 297, 16);
		contentPane.add(label);		
	}	
	
	public static void carregaTabelaVerQuesito(String tabela) {		
		StringBuffer sqlVerQuesito = new StringBuffer();
		if (tabela.equals("Comissão de Frente")) {
			tabela = "comissao_de_frente";
		} else if (tabela.equals("Evolução")) {
			tabela = "evolucao";
		}
		sqlVerQuesito.append("SELECT escola_de_samba.nome, nota1,");
		sqlVerQuesito.append(" nota2, nota3, nota4, nota5,");
		sqlVerQuesito.append(" menor_descartada, maior_descartada, nota_total");
		sqlVerQuesito.append(" FROM " + tabela);
		sqlVerQuesito.append(" INNER JOIN escola_de_samba");
		sqlVerQuesito.append(" ON " + tabela + ".id_escola = escola_de_samba.id_escola");		
		try {
			PreparedStatement stmt = generic.getConnection().prepareStatement(sqlVerQuesito.toString());
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				Quesito quesito = new Quesito();
				quesito.setNomeEscola(rs.getString(1));
				quesito.setNota1(rs.getDouble(2));
				quesito.setNota2(rs.getDouble(3));
				quesito.setNota3(rs.getDouble(4));
				quesito.setNota4(rs.getDouble(5));
				quesito.setNota5(rs.getDouble(6));
				quesito.setMenorDescartada(rs.getDouble(7));
				quesito.setMaiorDescartada(rs.getDouble(8));
				quesito.setNotaTotal(rs.getDouble(9));
				modelo.addRow(new Object[]{new String(quesito.getNomeEscola()),
						new Double(quesito.getNota1()), new Double(quesito.getNota2()),
						new Double(quesito.getNota3()), new Double(quesito.getNota4()),
						new Double(quesito.getNota5()), new Double(quesito.getMenorDescartada()),
						new Double(quesito.getMaiorDescartada()), new Double(quesito.getNotaTotal())});
			}			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
}
