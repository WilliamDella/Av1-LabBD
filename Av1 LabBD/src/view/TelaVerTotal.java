package view;

import java.awt.Color;
import java.awt.Component;
import java.awt.EventQueue;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.UIManager;
import javax.swing.UnsupportedLookAndFeelException;
import javax.swing.border.EmptyBorder;
import javax.swing.table.DefaultTableCellRenderer;
import javax.swing.table.DefaultTableModel;

import dao.GenericDAO;
import model.EscolasDeSamba;

public class TelaVerTotal extends JFrame {

	private static final long serialVersionUID = 1L;
	private JPanel contentPane;
	private JTable tabelaVerTotal;
	private final static DefaultTableModel modelo = new DefaultTableModel();
	private static GenericDAO generic = new GenericDAO();
	private String[] nomesColunas = {"Classificação", "Escola de Samba", "Total de Pontos"};
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
					TelaVerTotal frame = new TelaVerTotal();
					frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}
	
	public TelaVerTotal() {
		super("Ver Total - Classificação Geral");
		setBounds(100, 100, 383, 374);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);		
		
		JScrollPane scrollPane = new JScrollPane();
		scrollPane.setBounds(6, 6, 363, 336);
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
		
		carregaTabelaVerTotal();
		
		tabelaVerTotal = new JTable();		
		tabelaVerTotal.setModel(modelo);	
		
		Color corVerde = new Color(46, 204, 113);
		Color corDefault = new Color(236, 240, 241);
		Color corVermelha = new Color(231, 76, 60);
		
		final Color[] rowColors = new Color[] {
				corVerde, corDefault, corDefault, corDefault, corDefault,
				corDefault, corDefault, corDefault, corDefault,
				corDefault, corDefault, corDefault,
				corVermelha, corVermelha
		};
		
		DefaultTableCellRenderer dtcr =
                new DefaultTableCellRenderer() {
					private static final long serialVersionUID = 1L;

					public Component getTableCellRendererComponent(JTable table, Object value, boolean isSelected, boolean hasFocus, int row, int column) {  
                        Component comp = super.getTableCellRendererComponent(table, value, false, false, row, column);  
                        
                        comp.setBackground(rowColors[row]);
                        
                        return comp;  
                    } 
                };
                
        tabelaVerTotal.setDefaultRenderer(Object.class, dtcr);
		tabelaVerTotal.setRowHeight(22);
		tabelaVerTotal.getColumnModel().getColumn(0).setPreferredWidth(20);
		tabelaVerTotal.getColumnModel().getColumn(1).setPreferredWidth(90);
		tabelaVerTotal.getColumnModel().getColumn(2).setPreferredWidth(20);
		scrollPane.setViewportView(tabelaVerTotal);
	}
	
	public static void carregaTabelaVerTotal() {		
		StringBuffer sqlVerTotal = new StringBuffer();
		sqlVerTotal.append("SELECT * FROM view_total");
		sqlVerTotal.append(" ORDER BY total_de_pontos DESC");		
		try {
			PreparedStatement stmt = generic.getConnection().prepareStatement(sqlVerTotal.toString());
			ResultSet rs = stmt.executeQuery();
			int contador = 1;
			while (rs.next()) {
				EscolasDeSamba escola = new EscolasDeSamba();
				escola.setId_escola(contador);
				escola.setNome(rs.getString(1));
				escola.setTotal_de_pontos(rs.getDouble(2));
				modelo.addRow(new Object[]{new Integer(escola.getId_escola()),
						new String(escola.getNome()), new Double(escola.getTotal_de_pontos())});
				contador++;
			}			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
